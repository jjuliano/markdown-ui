module MarkdownUI
  module Renderers
    module Table
      def table(text)
        html { "<table class='ui table'>#{text}</table>" }
      end

      def table_header(text)
        html { "<thead>#{text}</thead>" }
      end

      def table_body(text)
        html { "<tbody>#{text}</tbody>" }
      end

      def table_row(text)
        html { "<tr>#{text}</tr>" }
      end

      def table_cell(text, alignment = nil)
        html { "<td>#{text}</td>" }
      end

      def table_header_cell(text, alignment = nil)
        html { "<th>#{text}</th>" }
      end
    end
  end
end