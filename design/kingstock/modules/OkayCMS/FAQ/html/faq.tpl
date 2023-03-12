{$canonical="{url_generator route="OkayCMS_FAQ_main" url=$product->url absolute=1}" scope=global}
<div class="block">
    {* The page heading *}
    <div class="block__header">
        <h1 class="block__heading">
            <span>{if $page->name_h1|escape}{$page->name_h1|escape}{else}{$page->name|escape}{/if}</span>
        </h1>
    </div>
    <div class="block__body">
        {if $faqs|count}
        <div class="faq">
            <ul class="fn_faq faq__list">
                {foreach $faqs as $faq}
                <li class="faq__item">
                    <div class="faq__question">
							<span class="faq__arrow"></span>
                        <span>{$faq->question|escape}</span>
                    </div>
                    <div class="faq__content">
                        <div class="faq__answer">
                            <div>{$faq->answer}</div>
                        </div>
                    </div>
                </li>
                {/foreach}
            </ul>
        </div>
        {/if}

        {* The page body *}
        {if $page->description}
            <div class="page-description__text boxed__description">{$page->description}</div>
        {/if}
    </div>
</div>
