<?php


namespace Okay\Modules\SimplaMarket\FacebookFeed\Init;


use Okay\Core\Modules\AbstractInit;

class Init extends AbstractInit
{
    const PERMISSION = 'simplamarket__facebook_feed';

    public function install()
    {
        $this->setBackendMainController('ModuleAdmin');
        if (!is_dir(__DIR__.'/../design/html/')){
            mkdir(__DIR__.'/../design/html/', 0777, true);
        }
    }

    public function init()
    {
        $this->addPermission(self::PERMISSION);
        $this->registerBackendController('ModuleAdmin');
        $this->addBackendControllerPermission('ModuleAdmin', self::PERMISSION);
    }
}