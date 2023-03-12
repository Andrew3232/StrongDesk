<?php

namespace Okay\Modules\Vitalisoft\Monobank;

use Okay\Core\Modules\AbstractModule;
use Okay\Core\Modules\Interfaces\PaymentFormInterface;
use Okay\Core\Router;

class PaymentForm extends AbstractModule implements PaymentFormInterface
{
    public function checkoutForm($orderId): string
    {
        $this->design->assign('url', Router::generateUrl(
            'Vitalisoft_Monobank_invoice', ['orderId' => $orderId], true));
        return $this->design->fetch('form.tpl');
    }
}