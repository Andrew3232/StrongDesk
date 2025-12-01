{if $product}
    {if empty($order)}
        <script>
            fbq('track', 'ViewContent', {$fp_content_data});
            ttq.track('ViewContent', {$tp_content_data});
        </script>
    {/if}
{/if}
