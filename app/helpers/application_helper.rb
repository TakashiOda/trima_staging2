module ApplicationHelper
  def default_meta_tags
    {
      site: 'trima',
      title: 'is a travel manage webapp',
      reverse: true,
      separator: '|',
      description: 'travel manage tool',
      keywords: 'trima',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'trima',
        title: 'trima',
        description: 'travel manage tool',
        type: 'website',
        url: request.original_url,
        image: image_url('trima_ogp_user_color.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@odayan3',
      },
      fb: {
        app_id: 'takashi.oda.921'
      }
    }
  end

  def supplier_meta_tags
    {
      site: 'trima トリマ',
      title: '旅行商品販売プラットフォーム',
      reverse: true,
      separator: '|',
      description: 'あらゆる旅行商品をオンライン販売、予約管理できるプラットフォーム',
      keywords: 'trima',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'trima トリマ',
        title: 'trima',
        description: 'あらゆる旅行商品をオンライン販売、予約管理できる観光事業者向けプラットフォーム',
        type: 'website',
        url: request.original_url,
        image: image_url('trima_ogp_supplier.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@odayan3',
      },
      fb: {
        app_id: 'takashi.oda.921'
      }
    }
  end
end
