require 'spec_helper'
require './libraries/default'

describe 'libraries::default' do
  describe 'collectd_key' do
    data = [
      [:optionab,    'Optionab'],
      [:OptionAB,    'OptionAB'],
      [:option_a_b,  'OptionAB'],
      [:Option_AB,   'OptionAb'],
    ]

    data.each do |cookbook_option, plugin_key|
      it "generates collectd plugin key for cookbook option '#{cookbook_option}'" do
        collectd_key(cookbook_option.to_sym).should == plugin_key
        collectd_key(cookbook_option.to_s).should == plugin_key
      end
    end
  end
end
