<?php


namespace Okay\Modules\SimplaMarket\FacebookFeed\Controllers;


use Okay\Controllers\AbstractController;
use Okay\Core\Image;
use Okay\Core\Languages;
use Okay\Core\QueryFactory;
use Okay\Core\Router;
use Okay\Entities\BrandsEntity;
use Okay\Entities\ImagesEntity;
use Okay\Entities\ProductsEntity;
use Okay\Entities\VariantsEntity;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;

class FeedController extends AbstractController
{
    public function render(
        QueryFactory $queryFactory,
        Languages    $languages,
        Image        $imageCore
    ) {
        header("Content-type: text/csv");
        header("Content-Disposition: attachment; filename=facebook_feed.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

	    $select = $queryFactory->newSelect()->from(ColorAssociationsEntity::getTable() . ' AS color')->cols([
			'color.id as id',
			'color.name as name',
	    ]);
	    $colorsResult = $select->results();
	    $colors = [];
		foreach($colorsResult as $color){
			$colors[$color->id] = $color->name;
		}
        // Getting all necessary information from the database
        $langId = $languages->getLangId();
        $select = $queryFactory->newSelect();
        $select ->from(VariantsEntity::getTable() . ' AS v')
                ->cols([
                    'v.id AS id',
                    'v.stock AS availability',
                    'l_p.description AS description',
                    'i.filename AS image_link',
                    'p.url AS link',
                    'v.product_id AS product_id',
                    'l_p.name AS title',
                    'v.price AS sale_price',
                    'v.name AS variant_name',
                    'v.compare_price AS price',
                    'v.sku AS brand',
                    'v.color AS color',
                    'v.shape AS shape',
                    'v.size AS size',
                    'v.material AS material',
                ])->groupBy(['product_id'])
                ->join('left', ProductsEntity::getTable() . ' AS p', 'p.id = v.product_id')
                ->join('left', ProductsEntity::getLangTable() . ' AS l_p', '(l_p.product_id = p.id AND l_p.lang_id = :lang_id)')
                ->join('left', ImagesEntity::getTable() . ' AS i', 'i.id = p.main_image_id')
                ->join('left', BrandsEntity::getLangTable() . ' AS l_b', '(l_b.brand_id = p.brand_id AND l_b.lang_id = :lang_id)')
                ->bindValues([
                    'lang_id' => $langId
                ]);
        $products = $select->results();

        $output = fopen(__DIR__.'/../feed.csv', "w");
        // Writing columns names to the file
        fputcsv($output, [
            'id',
            'availability',
            'condition',
            'description',
            'image_link',
            'link',
            'title',
            'sale_price',
            'price',
            'brand',
            'fb_product_category',
            'google_product_category',
//            'color',
//            'item_group_id',
        ],
        ',');

        // Writing variants to the file
        foreach ($products as $product) {
			$link = Router::generateUrl('product', ['url' => $product->link], true);
//			$params = [];
//	        if($product->material)
//	        {
//		        $params['material'] = $product->material;
//	        }
//	        if($product->size)
//	        {
//		        $params['size'] = $product->size;
//	        }
//			if($product->color)
//			{
//				$params['color'] = $product->color;
//			}
//			if($product->shape)
//			{
//				$params['shape'] = $product->shape;
//			}
//			if(!empty($params))
//			{
//				$link .= "?".http_build_query($params);
//			}
            $row = [
                $product->id,
                ($product->availability !== '0' ? 'in stock' : 'out of stock'),
                'new',
                htmlspecialchars_decode($product->description),
                $imageCore->getResizeModifier($product->image_link, 1200, 1200),
                $link,
                $product->title,
                $product->sale_price . ' UAH',
                (($product->price == null || $product->price <= $product->sale_price) ? $product->sale_price : $product->price) . ' UAH',
                (string) $product->brand,
                '77',
                '77',
//                $colors[$product->color],
//                'Desk_'.$product->product_id,
            ];
            fputcsv($output, $row, ',');
        }
        fclose($output);
        file_put_contents(
            __DIR__.'/../feed.csv',
            mb_convert_encoding(file_get_contents(__DIR__.'/../feed.csv'), 'UTF-8')
        );
        $out = fopen('php://output', 'w');
        fwrite($out, file_get_contents(__DIR__.'/../feed.csv'));
        fclose($out);
        die();
    }
}