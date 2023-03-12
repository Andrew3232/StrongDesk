<?php
use Okay\Modules\SimplaMarket\FacebookFeed\Controllers\FeedController;

return [
    'Simplamarket.FacebookFeed.Feed' => [
        'slug' => '/simplamarket/facebook_feed/feed',
        'params' => [
            'controller' => FeedController::class,
            'method' => 'render',
        ],
        'to_front' => false
    ],
];