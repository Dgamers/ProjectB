/*!
 * Star Rating Chinese Translations
 *
 * This file must be loaded after 'star-rating.js'. Patterns in braces '{}', or
 * any HTML markup tags in the messages must not be converted or translated.
 *
 * NOTE: this file must be saved in UTF-8 encoding.
 *
 * @see http://github.com/kartik-v/bootstrap-star-rating
 * @author Kartik Visweswaran <kartikv2@gmail.com>
 * @author Freeman
 */
 (function ($) {
    "use strict";
    $.fn.ratingLocales['zh'] = {
        defaultCaption: '{rating} 分',
        starCaptions: {
            0.5: '0.5分',
            1: '1分',
            1.5: '1.5分',
            2: '2分',
            2.5: '2.5分',
            3: '3分',
            3.5: '3.5分',
            4: '4分',
            4.5: '4.5分',
            5: '5分'
        },
        clearButtonTitle: '清除',
        clearCaption: '您的评分'
    };
})(window.jQuery);
