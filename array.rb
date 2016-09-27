class Array

  def my_map(&block)
    result = []
    each do |element|
      result << block.call(element)
    end
    result
  end

  def sort_arr(&block)
    if block.nil?
      sort
    else
      sort { block.call }
    end
  end
end
