<?php


namespace Okay\Modules\SimplaMarket\FacebookPixel\Backend\Controllers;


use Okay\Admin\Controllers\IndexAdmin;

class ModuleAdmin extends IndexAdmin
{
    public function fetch()
    {
        if ($this->request->method('post')) {
            $this->settings->set('simplamarket__facebook_pixel__account_id', $this->request->post('account'));
            $this->settings->update('simplamarket__facebook_pixel__product_catalog_id', $this->request->post('product_catalog_id'));
        }

        $this->response->setContent($this->design->fetch('module.tpl'));
    }
}