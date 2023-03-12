<?php


namespace Okay\Modules\Custom\VariantsMaterial\Entities;

use Okay\Core\Entity\Entity;

class MaterialAssociationsEntity extends Entity
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

    protected static $table = '__custom_materials_associations';
    protected static $langTable = 'custom_materials_associations';
    protected static $langObject = 'material_association';
    protected static $tableAlias = 'cmass';
}