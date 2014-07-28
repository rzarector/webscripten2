<?php

namespace GlennLatomme\Provider\Controller;

use Silex\Application;
use Silex\ControllerProviderInterface;
use Silex\ControllerCollection;

class Music implements ControllerProviderInterface {

    public function connect(Application $app) {

        // Create new ControllerCollection
        $controllers = $app['controllers_factory'];

        // Login
        $controllers
            ->match('/', array($this, 'overview'))
            ->before(array($this, 'forceFilter'))
            ->method('GET|POST')
            ->bind('overview');

        return $controllers;

    }

    public function overview(Application $app, \Symfony\Component\HttpFoundation\Request $request){

        //paginations
        $numItemsPerPage = 10;
        $curPage = max(1, (int) $request->query->get('p'));
        $numItems = $app['db.music']->countAlbums( $this->getFilter($app) );

        if ($numItems == 0){
            $music = $app['db.music']->findAll(
                $curPage, $numItemsPerPage
            );
            $numItems = count($music);
        } else {
            $music = $app['db.music']->findFiltered(
                $this->getFilter($app), $curPage, $numItemsPerPage
            );
        }


        $numPages = ceil($numItems / $numItemsPerPage);
        $paginationSequence = $this->generatePaginationSequence($curPage,$numPages);
        if ($curPage > $numPages){
            $app['session']->set('filter_products', array(
                'title' => '',
                'genre' => '',
                'year' => ''
            ));
            return $app->redirect($app['url_generator']->generate('overview'));
        }


        //Filter form
        $genres = $app['db.music']->getGenres();

        $genreChoice[0] = 'All genres';

        foreach ($genres as $genre){
            $genreChoice [ $genre['id']] = $genre['title'] ;
        }

        $filterForm = $app['form.factory']->createNamed('filterForm', 'form', $this->getFilter($app))
            ->add('title', 'text', [
                'attr' => [
                    'class' => 'form-control',
                ]
            ])
            ->add('genre', 'choice', [
                'choices' => $genreChoice,
                'attr' => [
                    'class' => 'form-control',
                ]
            ])
            ->add('year', 'text', [
                'attr' => [
                    'class' => 'form-control',
                ]
            ]);

        if ('POST' == $app['request']->getMethod()) {
            $filterForm->handleRequest($app['request']);
            if ($filterForm->isValid()) {
                $this->setFilter($app, $filterForm->getData());
            }
        }


        return $app['twig']->render('overview.twig', [
            'albums' => $music,
            'pagination' => $app['twig']->render('pagination.twig', [
                        'paginationSequence' => $paginationSequence,
                        'curPage' => $curPage,
                        'numPages' => $numPages,
                        'numItems' => $numItems,
                    ]
                ),
            'filterForm' => $filterForm->createView()
        ]);
    }

    public function forceFilter(\Symfony\Component\HttpFoundation\Request $request, Application $app) {
        if ($app['session']->get('filter_products') == null) {
            $app['session']->set('filter_products', array(
                'title' => '',
                'genre' => '',
                'year' => ''
            ));
        }
    }

    public function setFilter(Application $app, $filter) {
        $app['session']->set('filter_products', $filter);
    }

    public function getFilter(Application $app) {
        return $app['session']->get('filter_products');
    }

    function generatePaginationSequence($curPage, $numPages, $numberOfPagesAtEdges = 2, $numberOfPagesAroundCurrent = 2, $glue = '..', $indicateActive = false) {

        // Define the number of items we would generate in a normal scenario
        // (viz. lots of pages, current page in the middle):
        //
        // numItemsInSequence = the current page + the number of items surrounding
        // the current page (left and right) + the number of items at the edges
        // of the generated sequence (left and right) + the glue in between the
        // different parts generated
        //
        // The goal is to enforce all sequences generated to have this amount
        // of items. By default this magic number would be 11, as seen/counted
        // in this sequence: 1-02-..-11-12-[13]-14-15-..-88-74
        $numItemsInSequence = 1 + ($numberOfPagesAroundCurrent * 2) + ($numberOfPagesAtEdges * 2) + 2;

        // Fix: curPage cannot be greater than numPages.
        $curPage = min($curPage, $numPages);

        // If we have less than $numItemsInSequence pages in total, there is no need to
        // start calculating but just return the full sequence, starting at 1
        if ($numPages <= $numItemsInSequence) {
            $finalSequence = range(1, $numPages);
        }

        // We have more pages than $numItemsInSequence, start calculating
        else {

            // If we have no forced amount of items on the edges, then the
            // sequence must start from the current page number instead of 1
            $start = ($numberOfPagesAtEdges > 0) ? 1 : $curPage;

            // Parts of the sequence we'll be generating
            $sequence = array(
                'leftEdge' => null,
                'glueLeftCenter' => null,
                'centerPiece' => null,
                'glueCenterRight' => null,
                'rightEdge' => null
            );

            // If the current page is nearby the left edge (viz. curPage is
            // less than half of $numItemsInSequence away from left edge):
            // Don't generate a Center Piece, but extend the left part as
            // the left part would otherwise overlap the center piece.
            if ($curPage < ($numItemsInSequence/2)) {
                $sequence['leftEdge'] = range(1, ceil($numItemsInSequence/2) + $numberOfPagesAroundCurrent);
                $sequence['centerPiece'] = array($glue);
                if ($numberOfPagesAtEdges > 0) $sequence['rightEdge'] = range($numPages-($numberOfPagesAtEdges-1), $numPages);
            }

            // If the current page is nearby the right edge (viz. curPage is
            // less than half of $numItemsInSequence away from right edge):
            // Don't generate a center piece but extend the right part as
            // the right part would otherwise overlap the center piece.
            else if ($curPage > $numPages - ($numItemsInSequence/2)) {
                if ($numberOfPagesAtEdges > 0) $sequence['leftEdge'] = range($start, $numberOfPagesAtEdges);
                $sequence['centerPiece'] = array($glue);
                $sequence['rightEdge'] = range(min($numPages - floor($numItemsInSequence/2) - $numberOfPagesAroundCurrent, $curPage - $numberOfPagesAroundCurrent), $numPages);
            }

            // The current page falls somewhere in the middle:
            // Generate ranges normally
            else {

                // Center Piece
                $sequence['centerPiece'] = range($curPage - $numberOfPagesAroundCurrent, $curPage + $numberOfPagesAroundCurrent);

                // Left/Right Edges (only if we requested)
                if ($numberOfPagesAtEdges > 0) $sequence['leftEdge'] = range($start,$numberOfPagesAtEdges);
                if ($numberOfPagesAtEdges > 0) $sequence['rightEdge'] = range($numPages-($numberOfPagesAtEdges-1), $numPages);

                // The glue we'll use to stick left, center, and right together
                // Special case: If the gap between left and center is only one
                // unit, don't add '...' but add that number instead
                $sequence['glueLeftCenter'] = ($sequence['centerPiece'][0] == ($numberOfPagesAtEdges+2)) ? array($numberOfPagesAtEdges+1) : array($glue);
                $sequence['glueCenterRight'] = array($glue);

            }

            // Join all (non-empty) parts of sequence into the final sequence
            $finalSequence = array();
            foreach($sequence as $k => $v) {
                if ($v !== null) {
                    $finalSequence = array_merge($finalSequence, $v);
                }
            }

        }

        // Return the final sequence
        if ($indicateActive) {
            return array_replace($finalSequence, array(array_search($curPage, $finalSequence) => '[' . $curPage. ']'));
        } else {
            return $finalSequence;
        }

    }

}