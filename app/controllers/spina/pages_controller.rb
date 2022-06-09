class Spina::PagesController < Spina::ApplicationController
  include Spina::Frontend

  before_action :authorize_page
  before_action :merge_page_content

  def show
    template = page.view_template
    theme = current_tenant.preferences[:theme]
    render inertia: "#{theme}/#{template}"
  end

  def homepage
    template = page.view_template
    theme = current_tenant.preferences[:theme]
    render inertia: "#{theme}/homepage", props: {
      categories: categories
    }
  end

  private
    def merge_page_content
      for part in page.json_attributes['en_content']
        spina_content[part.attributes['name']] ||= part.attributes
      end
      spina_content['page_title'] = page.seo_title
      spina_content['page_description'] = page.description
    end

    def authorize_page
      raise ActiveRecord::RecordNotFound unless page.live? || logged_in?
    end

    def categories
      locale = I18n.locale
      [
        {
          name: 'Superior Apartment',
          description: locale == 'en' ? 
            'With spacious 59-63 sqm with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchen, a spacious bathroom with shower, living- and dining area with a small balcony as well as a separate bedroom with a king sized bed'  :
            'Auf geräumigen 59-63 m² mit Eingangsdiele bzw. Garderobe, einem HW-Raum mit Waschmaschine & Trockner, einer vollständig ausgestatteten Küche, einem Badezimmer mit Dusche, Wohn‐ und Essbereich mit kleinem Balkon sowie einem separaten Schlafzimmer mit einem King Size-Bett.',
          image_url: '/wellem/supa.jpg',
          smid: 'roomType-107519',
          amenities: {
            queen_size_bed: 1,
            bathtub: 1
          }
        },
        {
          name: 'Executive Apartment',
          description: locale == 'en' ? 
            'On 90 - 111 sqm with entrance area, a utility room with washing machine & dryer, a fully equipped kitchen, a spacious bathroom with shower, an additional guest toilet, a light-flooded living- and dining are with balcony as well as a separate bedroom with a king sized bed' :
            'Mit Eingangsdiele bzw. Garderobe, einem HW‐Raum mit Waschmaschine & Trockner, einer vollständig ausgestatteten Küche, einem Badezimmer mit Dusche und Wanne, einem separaten WC, einem lichtdurchfluteten Wohn‐ und Essbereich mit Balkon sowie einem separaten Schlafzimmer mit einem King Size‐Bett.',
          image_url: '/wellem/exap.jpg',
          smid: 'roomType-107521',
          amenities: {
            king_size_bed: 1,
            queen_size_bed: 1,
            bathtub: 1
          }
        },
        {
          name: 'Executive Apartment 2BR',
          description: locale == 'en' ? 
            'On 90 - 111 sqm with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchen, a spacious bathroom with shower, an additional guest toilet, a light-flooded living- and dining area with balcony as well as two separate sleeping rooms, one with a king sized bed and another one with a single bed' :
            'Auf 95 ‐ 111 m² mit Eingangsdiele bzw. Garderobe, einem HW‐Raum mitWaschmaschine & Trockner, einer vollständig ausgestatteten Küche, einem Badezimmer mit Dusche und Wanne, einem separaten WC, einem lichtdurchfluteten Wohn‐ und Essbereich mit Balkon sowie einem separaten Schlafzimmer mit einem King Size‐Bett und einem separaten Einzelschlafzimmer.',
          image_url: '/wellem/exap2br.jpg',
          smid: 'roomType-107520',
          amenities: {
            king_size_bed: 1,
            queen_size_bed: 1,
            bathtub: 1
          }
        },
        {
          name: 'Executive Penthouse 2BR',
          description: locale == 'en' ? 
            'Exclusive and urban styled executive maisonette penthouses with fully furnished roof terraces above the Düsseldorf roof tops. Elegant and stylish with a generous living and dining areas, high-quality, fully equipped kitchens, highly fitted out bathrooms with bathtubs and showers, separate utility rooms with washing machine and dryer. Two double bedrooms.' :
            'Exklusive und urbane Executive Maisonette‐Penthouses mit großen möblierten Dachterrassen über den Dächern von Düsseldorf. Elegant und stylish mit großzügigen Wohn‐ und Essbereichen, offenen, hochwertig ausgestatteten Küchen, geschmackvolle Badezimmer mit Dusche und Badewanne, separate Wirtschaftsräume mit Waschmaschinen und Trocknern, zwei Schlafzimmern.',
          image_url: '/wellem/ep2br.jpg',
          smid: 'roomType-107529',
          amenities: {
            king_size_bed: 1,
            queen_size_bed: 1,
            bathtub: 1
          }
        },
        {
          name: 'Penthouse',
          description: locale == 'en' ? 
            'Generous and bright 123 -127 sqm mark out our premium maisonette penthouses with their almost 50 sqm furnished roof terraces. Spacious entrance areas with HK rooms and additional toilets, lightflooded living- and dining areas with fully equipped kitchens and balconies, separate bedrooms and luxurous bathrooms with tubs and showers create a unique sense of living.' :
            'Großzügige und helle 123 ‐ 127 m² zeichnen die Penthouses 1 mit ihren großen möblierten Dachterrassen aus. Geräumige Eingangsbereiche mit HWR und WC, lichtdurchflutete Wohn‐ und Esszimmer mit komplett ausgestatteten Küchen und Balkonen, separate Schlafzimmer und luxuriöse Badezimmer mit Badewanne und Dusche kreieren ein einzigartiges Wohngefühl.',
          image_url: '/wellem/pent.jpg',
          smid: 'roomType-107526',
          amenities: {
            king_size_bed: 1,
            bathtub: 1
          }
        },
        {
          name: 'Premium Apartment',
          description: locale == 'en' ? 
            'On 70 – 90 sqm with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchenette, a spacious bathroom with shower, an additional toilet, living- and dining area as well as a separate bedroom with a king sized bed' :
            'Premium Apartment auf 75 – 84 m² mit Eingangsdiele bzw. Garderobe, einem HW‐Raum mit Waschmaschine & Trockner, einer vollständig ausgestatteten Küche, einem Badezimmer mit Dusche, einem separaten WC, Wohn‐ und Essbereich sowie einem separaten Schlafzimmer mit einem King Size‐Bett.',
          image_url: '/wellem/exap.jpg',
          smid: 'roomType-107522',
          amenities: {
            king_size_bed: 1,
            queen_size_bed: 1,
            bathtub: 1
          }
        },
        {
          name: 'Studio',
          description: locale == 'en' ? 
            'Small but precious, a comfortable studio on 46 sqm, with entrance area, a housekeeping room with washing machine & dryer, a fully equipped kitchenette, a spacious bathroom with shower, living- and dining area as well as a separated sleeping area with a queen sized bed' :
            'Klein aber fein mit Eingangsdiele bzw. Garderobe, einem HW‐Raum mit Waschmaschine & Trockner, einer vollständig ausgestatteten Küche, einem Badezimmer mit Dusche mit offenem Wohn‐ und Essbereich mit Bett.',
          image_url: '/wellem/studio.jpg',
          smid: 'roomType-107523',
          amenities: {
            king_size_bed: 1,
            bathtub: 1
          }
        }
      ]
    end
end