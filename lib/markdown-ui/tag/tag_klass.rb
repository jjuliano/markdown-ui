class TagKlass
  def content
    @content.strip unless @content.nil?
  end

  def klass
    MarkdownUI::KlassUtil.new(@klass).klass unless @klass.nil?
  end

  def _id
    if @id
      " id=\'#{@id.split.join('-')}\'"
    end
  end

  def data
    if @data
      _data, attribute, value = @data.split(':')
      " data-#{attribute}=\'#{value}\'"
    else
      nil
    end
  end

  def _input_id
    if @id
      " placeholder=\'#{@id.capitalize}\'"
    end
  end

  def input_content
    if @content
      " type=\'#{@content.strip.downcase}\'"
    else
      nil
    end
  end
end
