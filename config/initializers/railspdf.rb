# monkey patch RailsPDF renderer to force .html extension of tmp files, so that relaxedjs is not confsed with .pug exnteion
module RailsPDFPatches
    module RendererPatch
        def render(&block)
            controller = ActionController::Base.new
            view = ActionView::Base.new(ActionController::Base.view_paths, {}, controller)
            params = { file: @file, layout: @layout }
            params = params.merge(locals: @locals) if @locals.present?
            content = view.render(params)

            logger.debug "RailsPDF ====="
            logger.debug "RailsPDF content:\n#{content}"
            logger.debug "RailsPDF ====="

            begin
            input  = BetterTempfile.new("in.html")
            output = BetterTempfile.new("out.pdf")

            input.write(content)
            input.flush

            command = "#{RailsPDF.relaxed} #{input.path.to_s} #{output.path.to_s} --basedir / --build-once"

            logger.debug "RailsPDF ===== #{command}"

            err = Open3.popen3(*command) do |_stdin, _stdout, stderr|
                logger.debug _stdout.read
                logger.debug '------'
                logger.debug stderr.read
            end

            output.rewind
            output.binmode

            data = output.read

            yield(data)
            ensure
            input.try(:close!)
            output.try(:close!)
            end
        end

    end
end


RailsPDF::Renderer.prepend RailsPDFPatches::RendererPatch
