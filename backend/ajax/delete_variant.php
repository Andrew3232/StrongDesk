<?php

use Okay\Core\Design;

require_once 'configure.php';

// Проверка сессии для защиты от xss
if (!$request->checkSession()) {
	trigger_error('Session expired', E_USER_WARNING);
	exit();
}

$result = '';
/*Принимаем данные от объекта, который нужно обновить*/
$id = intval($request->get('id'));
$entity = $entityFactory->get(\Okay\Entities\VariantsEntity::class);

$result->id = $id;
if (!empty($id)) {
	$result = $entity->delete($id);
}

$response->setContent(json_encode($result), RESPONSE_JSON)->sendContent();