<?php


namespace Okay\Modules\Custom\VariantsShape\Entities;

use Okay\Core\Entity\Entity;

class ShapeAssociationsEntity extends Entity
{
    protected static $fields = [
        'id',
        'name',
    ];

    protected static $langFields = [
        'name',
    ];

    protected static $defaultOrderFields = [
        'id',
    ];

    protected static $table = '__custom_shapes_associations';
    protected static $langTable = 'custom_shapes_associations';
    protected static $langObject = 'shape_association';
    protected static $tableAlias = 'cmass';
}