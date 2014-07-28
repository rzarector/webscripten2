<?php

namespace GlennLatomme\Repository;

class Music extends \Knp\Repository {

    public function getTableName() {
        return 'albums';
    }

    public function findAll($curPage = 1, $numItemsPerPage = 10){
        return $this->db->fetchAll('
        SELECT albums.id, albums.title, albums.released, artists.title as artist_name
        from albums
        INNER JOIN artists ON albums.artist_id = artists.id
        ORDER by albums.title ASC
        LIMIT ' . (int) (($curPage - 1) * $numItemsPerPage) . ',' .
            (int) ($numItemsPerPage)
        );
    }

    public function lastID(){
        return $this->db->lastInsertId();
    }

    public function countAlbums($filter = null){
        $extraJoins = '';
        $extraWhere = '';

        // Title set via Filter
        if ($filter['title'] != '') {
            $extraWhere .= ' AND albums.title LIKE ' . $this->db->quote('%'.$filter['title'].'%', \PDO::PARAM_STR);
        }

        // Type set via Filter
        if ($filter['genre'] != 0) {
            $extraJoins .= ' INNER JOIN genres ON albums.genre_id = genres.id';
            $extraWhere .= ' AND genres.id = ' . $this->db->quote($filter['genre'], \PDO::PARAM_INT);
        }

        // Brand set via filter
        if ($filter['year'] != '') {
            $extraWhere .= ' AND albums.released = ' . $this->db->quote($filter['year'], \PDO::PARAM_INT);
        }

        return $this->db->fetchColumn('SELECT COUNT(*) FROM ' . $this->getTableName() . $extraJoins . ' WHERE albums.title is not null ' . $extraWhere,
            array('N')
        );
    }

    public function getGenres(){
        return $this->db->fetchAll('SELECT genres.title, genres.id FROM genres');
    }

    public function findFiltered($filter, $curPage = 1, $numItemsPerPage = 10) {
        $extraJoins = '';
        $extraWhere = '';



        // Title set via Filter
        if ($filter['title'] != '') {
            $extraWhere .= ' AND albums.title LIKE ' . $this->db->quote('%'.$filter['title'].'%', \PDO::PARAM_STR);
        }

        // Type set via Filter
        if ($filter['genre'] != 0) {
            $extraJoins .= ' INNER JOIN genres ON albums.genre_id = genres.id';
            $extraWhere .= ' AND genres.id = ' . $this->db->quote($filter['genre'], \PDO::PARAM_INT);
        }

        // Brand set via filter
        if ($filter['year'] != '') {
            $extraWhere .= ' AND albums.released = ' . $this->db->quote($filter['year'], \PDO::PARAM_INT);
        }

        $extraJoins .= ' INNER JOIN artists ON albums.artist_id = artists.id';

        return $this->db->fetchAll('
SELECT albums.id, albums.title, albums.released, artists.title as artist_name FROM albums' . $extraJoins . ' WHERE albums.title is not null ' . $extraWhere .'
ORDER BY title ASC
LIMIT ' . (int) (($curPage - 1) * $numItemsPerPage) . ',' .
            (int) ($numItemsPerPage),
            array('N')
        );

    }
}