{if $settings->simplamarket__facebook_pixel__account_id && $order && !$order->facebook_pixel__purchase_sended}
    <script>
    fbq('track', 'Purchase', {$fp_purchase_data});
    </script>
{/if}