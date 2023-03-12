<?php

use Okay\Admin\Helpers\BackendProductsHelper;
use Okay\Admin\Helpers\BackendVariantsHelper;
use Okay\Core\Design;

require_once 'configure.php';

// Проверка сессии для защиты от xss
if (!$request->checkSession()) {
	trigger_error('Session expired', E_USER_WARNING);
	exit();
}

$backendVariantsHelper = $DI->get(BackendVariantsHelper::class);
$backendProductsHelper = $DI->get(BackendProductsHelper::class);
$entity = $entityFactory->get(\Okay\Entities\VariantsEntity::class);

$result = new \stdClass();
/*Принимаем данные от объекта, который нужно обновить*/
$productId = intval($request->get('product_id'));
$variant = (object)$request->get('variant');
$variant->volume = 0.00000; // for nova poshta

$productVariants = [$variant];
$product = $backendProductsHelper->getProduct($productId);

$productVariants = $backendVariantsHelper->prepareUpdateVariants($productVariants);
$backendVariantsHelper->updateVariants($product, $productVariants);
//prepare
//if (property_exists($variant, 'stock') && ($variant->stock == '∞' || $variant->stock == '')) {
//	$variant->stock = null;
//}
//if (!empty($variant->price)) {
//	$variant->price = $variant->price > 0 ? str_replace(',', '.', $variant->price) : 0;
//}
//if (!empty($variant->compare_price)) {
//	$variant->compare_price = $variant->compare_price > 0 ? str_replace(',', '.', $variant->compare_price) : 0;
//}
//$variant->volume = 0.00000;

// update or save
//if (!empty($variant->id)) {
//	$entity->update($variant->id, $variant);
//	$variant = $entity->get((int)$variant->id);
//} else {
//	$variant->product_id = $productId;
//	$variant->id = $entity->add($variant);
//}

$result = $entity->findOne(['id'=>$variant->id]);

$response->setContent(json_encode($result), RESPONSE_JSON)->sendContent();