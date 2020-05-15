require 'spec_helper'

describe Payment do
  subject { described_class.new(payment_attributes) }

  describe '.new' do
    let(:payment_attributes) do
      {
        intent: 'sale',
        payer: { payment_method: 'paypal' },
        application_context: {
          brand_name: 'My Brand',
          locale: 'en_US',
          landing_page: 'Billing',
          shipping_preference: 'NO_SHIPPING',
          user_action: 'commit',
          preferred_payment_source: {
            token: {
              id: 'payment-token-id-generated-by-paypal',
              type: 'BILLING_AGREEMENT'
            }
          }
        }
      }
    end

    describe '"application_context" key' do
      let(:application_context) { subject.application_context }

      it 'should convert the "application_context" value in an instance of ApplicationContext DataType' do
        expect(application_context).to be_a ApplicationContext
      end

      it 'should set "brand_name" value correctly' do
        expect(application_context.brand_name).to eq 'My Brand'
      end

      it 'should set "locale" value correctly' do
        expect(application_context.locale).to eq 'en_US'
      end

      it 'should set "landing_page" value correctly' do
        expect(application_context.landing_page).to eq 'Billing'
      end

      it 'should set "shipping_preference" value correctly' do
        expect(application_context.shipping_preference).to eq 'NO_SHIPPING'
      end

      it 'should set "user_action" value correctly' do
        expect(application_context.user_action).to eq 'commit'
      end

      describe '"preferred_payment_source" key' do
        let(:payment_source) { application_context.preferred_payment_source }

        it 'should convert "preferred_payment_source" in an instance of ApplicationContextPaymentSource datatype' do
          expect(payment_source).to be_a ApplicationContextPaymentSource
        end

        describe '"preferred_payment_source.token" key' do
          let(:token) { payment_source.token }

          it 'should convert "token" in an instance of PaymentSourceToken datatype' do
            expect(token).to be_a PaymentSourceToken
          end

          it 'should set "id" value correctly' do
            expect(token.id).to eq 'payment-token-id-generated-by-paypal'
          end

          it 'should set "type" value correctly' do
            expect(token.type).to eq 'BILLING_AGREEMENT'
          end
        end
      end
    end
  end
end
