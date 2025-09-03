# coding: UTF-8
require_relative 'test_helper'

class ProgressTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_progress
    markdown = '__Progress|75__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui progress" data-percent="75">
  <div class="bar" style="width: 75%"></div>
</div>
', output
  end

  def test_progress_with_label
    markdown = '__Progress|Uploading Files|60__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui progress" data-percent="60">
  <div class="bar" style="width: 60%">
    <div class="progress">60%</div>
  </div>
  <div class="label">Uploading Files</div>
</div>
', output
  end

  def test_indicating_progress
    markdown = '__Progress|Loading|45|indicating__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui indicating progress" data-percent="45">
  <div class="bar" style="width: 45%">
    <div class="progress">45%</div>
  </div>
  <div class="label">Loading</div>
</div>
', output
  end

  def test_success_progress
    markdown = '__Progress|Complete|100|success__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui success progress" data-percent="100">
  <div class="bar" style="width: 100%">
    <div class="progress">100%</div>
  </div>
  <div class="label">Complete</div>
</div>
', output
  end

  def test_warning_progress
    markdown = '__Progress|Warning|85|warning__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui warning progress" data-percent="85">
  <div class="bar" style="width: 85%">
    <div class="progress">85%</div>
  </div>
  <div class="label">Warning</div>
</div>
', output
  end

  def test_error_progress
    markdown = '__Progress|Error|25|error__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui error progress" data-percent="25">
  <div class="bar" style="width: 25%">
    <div class="progress">25%</div>
  </div>
  <div class="label">Error</div>
</div>
', output
  end

  def test_active_progress
    markdown = '__Progress|Processing|50|active__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui active progress" data-percent="50">
  <div class="bar" style="width: 50%">
    <div class="progress">50%</div>
  </div>
  <div class="label">Processing</div>
</div>
', output
  end

  def test_disabled_progress
    markdown = '__Progress|Disabled|30|disabled__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui disabled progress" data-percent="30">
  <div class="bar" style="width: 30%"></div>
  <div class="label">Disabled</div>
</div>
', output
  end

  def test_inverted_progress
    markdown = '__Progress|Inverted|70|inverted__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui inverted progress" data-percent="70">
  <div class="bar" style="width: 70%">
    <div class="progress">70%</div>
  </div>
  <div class="label">Inverted</div>
</div>
', output
  end

  def test_attached_progress
    markdown = '__Progress|Attached|40|attached__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui attached progress" data-percent="40">
  <div class="bar" style="width: 40%"></div>
</div>
', output
  end

  def test_tiny_progress
    markdown = '__Progress|Tiny|20|tiny__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui tiny progress" data-percent="20">
  <div class="bar" style="width: 20%"></div>
  <div class="label">Tiny</div>
</div>
', output
  end

  def test_small_progress
    markdown = '__Progress|Small|35|small__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui small progress" data-percent="35">
  <div class="bar" style="width: 35%"></div>
  <div class="label">Small</div>
</div>
', output
  end

  def test_medium_progress
    markdown = '__Progress|Medium|55|medium__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui medium progress" data-percent="55">
  <div class="bar" style="width: 55%"></div>
  <div class="label">Medium</div>
</div>
', output
  end

  def test_large_progress
    markdown = '__Progress|Large|80|large__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui large progress" data-percent="80">
  <div class="bar" style="width: 80%"></div>
  <div class="label">Large</div>
</div>
', output
  end

  def test_big_progress
    markdown = '__Progress|Big|90|big__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui big progress" data-percent="90">
  <div class="bar" style="width: 90%"></div>
  <div class="label">Big</div>
</div>
', output
  end
end