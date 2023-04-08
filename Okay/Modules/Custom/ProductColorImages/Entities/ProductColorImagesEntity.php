<?php

namespace Okay\Modules\Custom\ProductColorImages\Entities;

use Okay\Core\Entity\Entity;

class ProductColorImagesEntity extends Entity
{
    protected static $fields = [
        'id',
        'product_id',
        'color_id',
        'filename',
    ];

    protected static $defaultOrderFields = [
        'id',
    ];

    protected static $table = '__custom_product_color_images';
//	protected static $langTable = 'custom_product_color_images';
//	protected static $langObject = 'product_color_images';
    protected static $tableAlias = 'cpcimg';
}