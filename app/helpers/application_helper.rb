module ApplicationHelper

	def alert_class(alert)
		cls = 'alert'
		case alert.to_s
		when 'success'
			cls << ' alert-success'
		when 'notice'
			cls << ' alert-warning'
		when 'error'
			cls << ' alert-danger'
		end
		cls
	end

	def button_class(type)
		case type
		when 1
			'btn btn-info'
		when 2
			'btn btn-primary'
		when 3
			'btn btn-warning'
		when 4
			'btn btn-danger'
		end
	end
end
