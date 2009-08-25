# encoding: utf-8

gem "prawn", "~> 0.4"
require "prawn"

module Stories
  class Runner::PDF < Runner
    def render_header(pdf)
    end

    def finished(elapsed_time)
      super

      Prawn::Document.generate("stories.pdf", :page_size => "A4") do |pdf|
        render_header(pdf)

        pdf.text "User Acceptance Tests", :size => 20, :style => :bold
        
        pdf.move_down(15)

        Stories.all.values.each do |story|
          pdf.text story.name, :style => :bold

          story.scenarios.each_with_index do |scenario,i|
            scenario_leading = 15

            pdf.span(pdf.bounds.width - scenario_leading, :position => scenario_leading) do
              pdf.text "— #{scenario.name}"

              pdf.fill_color "666666"

              unless scenario.steps.empty? && scenario.assertions.empty?
                pdf.span(pdf.bounds.width - 30, :position => 30) do
                  pdf.font_size(9) do
                    render_many(pdf, scenario.steps)
                    render_many(pdf, scenario.assertions)
                  end
                end
              end

              pdf.move_down(5) unless i + 1 == story.scenarios.size
              
              pdf.fill_color "000000"
            end
          end

          pdf.move_down(10)
        end
      end
    end

    def render_many(pdf, elements)
      elements.each do |el|
        pdf.text el.to_s
      end
    end
  end
end
