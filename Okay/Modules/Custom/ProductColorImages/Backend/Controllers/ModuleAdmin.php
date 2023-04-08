<?php

namespace Okay\Modules\Custom\ProductColorImages\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;

class ModuleAdmin extends IndexAdmin
{
    public function fetch()
    {
        $this->response->setContent($this->design->fetch('description.tpl'));
    }
}