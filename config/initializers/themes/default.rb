# Theme configuration file
# ========================
# This file is used for all theme configuration.
# It's where you define everything that's editable in Spina CMS.

Spina::Theme.register do |theme|
  # All views are namespaced based on the theme's name
  theme.name = 'default'
  theme.title = 'Default theme'
  
  # Parts 
  # Define all editable parts you want to use in your view templates
  # 
  # Built-in part types:
  # - Line
  # - MultiLine
  # - Text (Rich text editor)
  # - Image
  # - ImageCollection
  # - Attachment
  # - Option
  # - Repeater
  theme.parts = [
    {name: 'logo', title: 'Logo', part_type: "Spina::Parts::Image"},
    {name: 'favicon', title: 'Favicon', hint: 'The icon that appears in the browser tab', part_type: "Spina::Parts::Image"},
    {name: 'tagline1', title: 'Tagline 1', part_type: "Spina::Parts::Line"},
    {name: 'tagline2', title: 'Tagline 2', part_type: "Spina::Parts::Line"},
    {name: 'welcome', title: 'Welcome', part_type: "Spina::Parts::Line"},
    {name: 'intro', title: 'Intro', part_type: "Spina::Parts::MutliLine"},
    {name: 'header_images', title: 'Header Images', part_type: "Spina::Parts::ImageCollection"},
    {name: 'text',  title: "Text", part_type: "Spina::Parts::Text"},
    {name: 'question',  title: "Question", part_type: "Spina::Parts::Text"},
    {name: 'answer',  title: "Answer", part_type: "Spina::Parts::Text"},
    {name: 'images', title: 'Images', part_type: "Spina::Parts::ImageCollection"},
    {name: 'title', title: 'Title', part_type: "Spina::Parts::Line"},
    {
      name: "style",
      title: "Style",
      options: ["plain", "parallax", "mosaic"],
      part_type: "Spina::Parts::Option"
    },
    {
      name: "sections",
      title: "Sections",
      parts: %w(title images text style),
      part_type: "Spina::Parts::Repeater"
    },
    {
      name: "faq",
      title: "FAQ",
      parts: %w(question answer),
      part_type: "Spina::Parts::Repeater"
    }
    
  ]
  
  # View templates
  # Every page has a svelte template assigned
  # you can find it in app/javascript/pages/[theme]/*
  # You define which parts you want to enable for every view template
  # by referencing them from the theme.parts configuration above.
  theme.view_templates = [
    {name: 'homepage', title: 'with Accomodations', parts: %w(header_images tagline1 tagline2 welcome intro)},
    {name: 'sections', title: 'with Sections', parts: %w(header_images tagline1 tagline2 sections)},
    {name: 'faq', title: 'with FAQ', parts: %w(header_images tagline1 tagline2 faq)},
    {name: 'contact', title: 'with Contact Form', parts: %w(header_images tagline1 tagline2)}
  ]
  
  # Custom pages
  # Some pages should not be created by the user, but generated automatically.
  # By naming them you can reference them in your code.
  # theme.custom_pages = [
  #   {name: 'homepage', title: "Homepage", deletable: false, view_template: "homepage"},
  # ]
  
  # Navigations (optional)
  # If your tenant has multiple navigations, it can be useful to configure multiple
  # navigations.
  theme.navigations = [
    {name: 'header', label: 'Header Navigation'},
    {name: 'footer', label: 'Footer Navigation'}
  ]
  
  # Layout parts (optional)
  # You can create global content that doesn't belong to one specific page. We call these layout parts.
  # You only have to reference the name of the parts you want to have here.
  theme.layout_parts = [
    'logo', 'favicon'
  ]
  
  # Resources (optional)
  # Think of resources as a collection of pages. They are managed separately in Spina
  # allowing you to separate these pages from the 'main' collection of pages.
  theme.resources = []
  
  # Plugins (optional)
  theme.plugins = []
  
  # Embeds (optional)
  theme.embeds = []
end
