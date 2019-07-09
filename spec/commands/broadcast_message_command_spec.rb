require 'rails_helper'

class TestConnection
  attr_reader :identifiers, :logger

  def initialize(identifiers_hash = {})
    @identifiers = identifiers_hash.keys
    @logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(StringIO.new))

    identifiers_hash.each do |identifier, value|
      define_singleton_method(identifier) do
        value
      end
    end
  end
end

RSpec.describe BroadcastMessageCommand do
  let(:command) { described_class.new(message, user) }
  let(:message) { create(:message) }
  let(:user) { nil }
  let(:channel) { MessagesChannel.new(connection, {}) }
  let(:uuid) { SecureRandom.urlsafe_base64 }
  let(:connection) { TestConnection.new(uuid: uuid) }
  let(:action_cable) { ActionCable.server }

  describe '#create' do
    let(:action) { 'create' }
    subject { command.create }

    it 'broadcasts new message' do
      expect(action_cable).to receive(:broadcast).with('messages', hash_including(action: action, id: message.id))

      subject
    end
  end

  describe '#update' do
    let(:action) { 'update' }
    subject { command.update }

    it 'broadcasts updated message' do
      expect(action_cable).to receive(:broadcast).with('messages', hash_including(action: action, id: message.id))

      subject
    end
  end

  describe '#destroy' do
    let(:action) { 'destroy' }
    subject { command.destroy }

    it 'broadcasts destroyed message' do
      expect(action_cable).to receive(:broadcast).with('messages', hash_including(action: action, id: message.id))

      subject
    end
  end
end
