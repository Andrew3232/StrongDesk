<?php
namespace Okay\Modules\Simplamarket\EmailNotRequired\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;

class DescriptionAdmin extends IndexAdmin
{
    public function fetch()
    {
        $this->response->setContent($this->design->fetch('description.tpl'));
    }
}