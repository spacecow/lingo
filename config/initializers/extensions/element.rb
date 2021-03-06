require 'capybara' 

module Capybara
  module Node
    class Element < Base
      def tags(tag,cl)
        all(:css, "#{tag}.#{cl}")
      end
      def divs(cl) tags(:div,cl) end
      def forms(cl) tags(:form,cl) end
      def divs_no(s); divs(s).count end
      def forms_no(s); forms(s).count end

      def div(s,i=-1)
        if i<0
          find(:css,"div##{s}") 
        else
          all(:css,"div.#{s}")[i]
        end
      end
      def divs_text(s)
        divs(s).map{|e| e.text.strip}.join(', ')
      end
      def h2; find(:css, "h2") end
      def li(s,i=-1)
        if s.instance_of? Fixnum 
          lis[s]
        elsif i<0
          find(:css,"li##{s}") 
        else
          all(:css,"li.#{s}")[i]
        end
      end
      def lis_no(s=nil); lis(s).count end
      def options(lbl)
        find_field(lbl).all(:css,"option").map{|e| e.text.blank? ? "BLANK" : e.text}.join(', ')
      end
      def selected_value(s)
        begin
          find_field(s).find(:xpath,"//option[@selected='selected']").text
        rescue
          nil 
        end
      end
      def rows_no; all(:css,'tr').count end
      def span(id,i=-1)
        if i<0
          find(:css,"span##{id.to_s}")
        else
          all(:css,"span.#{id.to_s}")[i] 
        end
      end
      def tables_no(s); tables(s).count end
      def ul(id); find(:css,"ul##{id.to_s}") end

      private

        def lis(s=nil)
          if s.nil?
            all('li')
          else
            all(:css, "li.#{s}")
          end
        end
    end
  end
end
