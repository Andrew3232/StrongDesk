<?php

namespace Okay\Modules\Vitalisoft\Monobank\Init;

use Okay\Core\Modules\AbstractInit;

class Init extends AbstractInit
{

    public function install()
    {
        $this->setModuleType(MODULE_TYPE_PAYMENT);
        $this->setBackendMainController("DescriptionAdmin");
    }

    public function init()
    {
        $this->addPermission('vitalisoft__monobank');

        $this->registerBackendController('DescriptionAdmin');
        $this->addBackendControllerPermission('DescriptionAdmin', 'vitalisoft__monobank');
    }
}