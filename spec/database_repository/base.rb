require 'spec_helper'
require 'active_record'
require File.expand_path('../../../lib/database_repository/base', __FILE__)

RSpec.describe DatabaseRepository::Base do

  class User < ActiveRecord::Base; end
  class UserRepository < DatabaseRepository::Base; end

  let(:repository) { UserRepository.new }

  let(:id) { 1 }
  let(:attributes) { { a: 1, b: 2 } }
  let(:user_double) { instance_double(User) }

  describe '#all' do
    subject { repository.all }

    it 'calls ActiveRecord all' do
      expect(User).to receive(:all)
      subject
    end
  end

  describe '#build' do
    subject { repository.build(attributes) }

    it 'calls ActiveRecord new with passed attributes' do
      expect(User).to receive(:new).with(attributes)
      subject
    end
  end

  describe '#find' do
    subject { repository.find(id) }

    context 'record exists' do
      it 'calls ActiveRecord find' do
        expect(User).to receive(:find).with(id)
        subject
      end
    end

    context 'record does not exist' do
      before { allow(User).to receive(:find).with(id).and_raise(ActiveRecord::RecordNotFound) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordNotFound)
      end
    end
  end

  describe '#find_by' do
    subject { repository.find_by(attributes) }

    it 'calls ActiveRecord find_by with passed attributes' do
      expect(User).to receive(:find_by).with(attributes)
      subject
    end
  end

  describe '#find_or_initialize_by' do
    subject { repository.find_or_initialize_by(attributes) }

    it 'calls ActiveRecord find_or_initialize_by with passed attributes' do
      expect(User).to receive(:find_or_initialize_by).with(attributes)
      subject
    end
  end

  describe '#find_or_create_by' do
    subject { repository.find_or_create_by(attributes) }

    it 'calls ActiveRecord find_or_create_by with passed attributes' do
      expect(User).to receive(:find_or_create_by).with(attributes)
      subject
    end
  end

  describe '#find_or_create_by!' do
    subject { repository.find_or_create_by!(attributes) }

    context 'valid attributes' do
      it 'calls ActiveRecord find_or_create_by!' do
        expect(User).to receive(:find_or_create_by!).with(attributes)
        subject
      end
    end

    context 'invalid attributes' do
      before { allow(User).to receive(:find_or_create_by!).with(attributes).and_raise(ActiveRecord::RecordInvalid) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordInvalid)
      end
    end
  end

  describe '#first' do
    subject { repository.first }

    it 'calls ActiveRecord first' do
      expect(User).to receive(:first)
      subject
    end
  end

  describe '#first!' do
    subject { repository.first! }

    context 'record exists' do
      it 'calls ActiveRecord first!' do
        expect(User).to receive(:first!)
        subject
      end
    end

    context 'record does not exist' do
      before { allow(User).to receive(:first!).and_raise(ActiveRecord::RecordNotFound) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordNotFound)
      end
    end
  end

  describe '#last' do
    subject { repository.last }

    it 'calls ActiveRecord last' do
      expect(User).to receive(:last)
      subject
    end
  end

  describe '#last!' do
    subject { repository.last! }

    context 'record exists' do
      it 'calls ActiveRecord last!' do
        expect(User).to receive(:last!)
        subject
      end
    end

    context 'record does not exist' do
      before { allow(User).to receive(:last!).and_raise(ActiveRecord::RecordNotFound) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordNotFound)
      end
    end
  end

  describe '#create' do
    subject { repository.create(attributes) }

    it 'calls ActiveRecord create with passed attributes' do
      expect(User).to receive(:create).with(attributes)
      subject
    end
  end

  describe '#create!' do
    subject { repository.create!(attributes) }

    context 'valid attributes' do
      it 'calls ActiveRecord create!' do
        expect(User).to receive(:create!).with(attributes)
        subject
      end
    end

    context 'invalid attributes' do
      before { allow(User).to receive(:create!).with(attributes).and_raise(ActiveRecord::RecordInvalid) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordInvalid)
      end
    end
  end

  describe '#update' do
    subject { repository.update(id, attributes) }

    before { allow(User).to receive(:find).with(id).and_return(user_double) }

    it 'calls ActiveRecord update with passed attributes' do
      expect(user_double).to receive(:update).with(attributes)
      subject
    end
  end

  describe '#update!' do
    subject { repository.update!(id, attributes) }

    before { allow(User).to receive(:find).with(id).and_return(user_double) }

    context 'valid attributes' do
      it 'calls ActiveRecord update!' do
        expect(user_double).to receive(:update!).with(attributes)
        subject
      end
    end

    context 'invalid attributes' do
      before { allow(user_double).to receive(:update!).with(attributes).and_raise(ActiveRecord::RecordInvalid) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordInvalid)
      end
    end
  end

  describe '#update_all' do
    subject { repository.update_all(attributes) }

    it 'calls ActiveRecord update_all with passed attributes' do
      expect(User).to receive(:update_all).with(attributes)
      subject
    end
  end

  describe '#delete' do
    subject { repository.delete(id) }

    before { allow(User).to receive(:find).with(id).and_return(user_double) }

    it 'calls ActiveRecord delete' do
      expect(user_double).to receive(:delete)
      subject
    end
  end

  describe '#destroy' do
    subject { repository.destroy(id) }

    before { allow(User).to receive(:find).with(id).and_return(user_double) }

    it 'calls ActiveRecord destroy' do
      expect(user_double).to receive(:destroy)
      subject
    end
  end

  describe '#destroy!' do
    subject { repository.destroy!(id) }

    before { allow(User).to receive(:find).with(id).and_return(user_double) }

    context 'record exists' do
      it 'calls ActiveRecord destroy!' do
        expect(user_double).to receive(:destroy!)
        subject
      end
    end

    context 'record does not exist' do
      before { allow(user_double).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed) }

      it 'raises DatabaseRepository::RecordNotFound error' do
        expect { subject }.to raise_error(DatabaseRepository::RecordNotDestroyed)
      end
    end
  end

  describe '#delete_all' do
    subject { repository.delete_all }

    it 'calls ActiveRecord delete_all' do
      expect(User).to receive(:delete_all)
      subject
    end
  end

  describe '#destroy_all' do
    subject { repository.destroy_all }

    it 'calls ActiveRecord destroy_all' do
      expect(User).to receive(:destroy_all)
      subject
    end
  end

  describe '.entity' do
    class Model < ActiveRecord::Base; end

    before do
      class UserRepository < DatabaseRepository::Base
        entity 'Model'
      end
    end

    it 'sets an entity class name and calls methods by an entity class name' do
      expect(Model).to receive(:all)
      repository.all
    end
  end
end
