RSpec.describe EventSerializer::Facebook::MessagingOptins do
  TIMESTAMP ||= 1458692752478

  describe '.new' do
    context 'invalid params' do
      it { expect { EventSerializer::Facebook.new(nil) }.to raise_error('Supplied Option Is Nil') }
    end
  end

  describe '#serialize' do
    subject { EventSerializer::Facebook::MessagingOptins.new(data).serialize }

    let(:data) {
      {
        "sender":{
          "id":"USER_ID"
        },
        "recipient":{
          "id":"PAGE_ID"
        },
        "timestamp":TIMESTAMP,
        "optin":{
          "ref":"PASS_THROUGH_PARAM"
        }
      }
    }
    let(:serialized) {
      {
        data:  {
          event_type: "messaging_optins",
          is_for_bot: true,
          is_im: true,
          is_from_bot: false,
          provider: "facebook",
          created_at: Time.at(TIMESTAMP.to_f / 1000),
          event_attributes: {
            optin: { ref: "PASS_THROUGH_PARAM" }
          }},
        recip_info: {
          sender_id: "USER_ID", recipient_id: "PAGE_ID"
        }
      }
    }

    it { expect(subject).to eql serialized }
  end
end
