<?php

// Bootstrap
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

$app->mount('/music/', new GlennLatomme\Provider\Controller\Music());


// Basic Routing
$app->get('/', function(Silex\Application $app) {
    return $app->redirect($app['url_generator']->generate('overview'));
});