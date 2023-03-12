<?php


namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Entities;


use Okay\Core\Entity\Entity;

class ColorAssociationsEntity extends Entity
{
    protected static $fields = [
        'id',
        'name',
        'hex',
        'image',
    ];

    protected static $langFields = [
        'name',
    ];

    protected static $defaultOrderFields = [
        'id',
    ];

    protected static $table = '__simplamarket_colors_associations';
    protected static $langTable = 'simplamarket_colors_associations';
    protected static $langObject = 'color_association';
    protected static $tableAlias = 'cass';
}