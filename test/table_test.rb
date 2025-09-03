# coding: UTF-8
require_relative 'test_helper'

class TableTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_table_with_class_and_id
    markdown = '__.data-table#users-table Table|Name,Email,Role|John,john@example.com,Admin|Jane,jane@example.com,User__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui table data-table" id="users-table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Email
</th>
      <th>
Role
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
john@example.com
</td>
      <td>
Admin
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
jane@example.com
</td>
      <td>
User
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_definition_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|definition__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui definition table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_striped_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|striped__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui striped table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_celled_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|celled__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui celled table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_basic_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|basic__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui basic table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_very_basic_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|very basic__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui very basic table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_collapsing_table
    markdown = '__Table|Name,Age|John,30|Jane,25|collapsing__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui collapsing table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_fixed_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|fixed__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui fixed table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_inverted_table
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|inverted__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui inverted table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Age
</th>
      <th>
Job
</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
John
</td>
      <td>
30
</td>
      <td>
Developer
</td>
    </tr>
    <tr>
      <td>
Jane
</td>
      <td>
25
</td>
      <td>
Designer
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_positive_table
    markdown = '__Table|Name,Status,Action|John,Active,Edit|Jane,Pending,Review|positive__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui positive table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Status
</th>
      <th>
Action
</th>
    </tr>
  </thead>
  <tbody>
    <tr class="positive">
      <td>
John
</td>
      <td>
Active
</td>
      <td>
Edit
</td>
    </tr>
    <tr class="positive">
      <td>
Jane
</td>
      <td>
Pending
</td>
      <td>
Review
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_negative_table
    markdown = '__Table|Name,Status,Action|John,Error,Fix|Jane,Failed,Retry|negative__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui negative table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Status
</th>
      <th>
Action
</th>
    </tr>
  </thead>
  <tbody>
    <tr class="negative">
      <td>
John
</td>
      <td>
Error
</td>
      <td>
Fix
</td>
    </tr>
    <tr class="negative">
      <td>
Jane
</td>
      <td>
Failed
</td>
      <td>
Retry
</td>
    </tr>
  </tbody>
</table>
', output
  end

  def test_warning_table
    markdown = '__Table|Name,Status,Action|John,Warning,Check|Jane,Alert,Review|warning__'
    output = @parser.parse(markdown)
    assert_equal \
'<table class="ui warning table">
  <thead>
    <tr>
      <th>
Name
</th>
      <th>
Status
</th>
      <th>
Action
</th>
    </tr>
  </thead>
  <tbody>
    <tr class="warning">
      <td>
John
</td>
      <td>
Warning
</td>
      <td>
Check
</td>
    </tr>
    <tr class="warning">
      <td>
Jane
</td>
      <td>
Alert
</td>
      <td>
Review
</td>
    </tr>
  </tbody>
</table>
', output
  end
end