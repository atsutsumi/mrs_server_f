# -*- coding:utf-8 -*-
require "socket"

module Lgdisit
	# Enqueues a packet to the queue server.
	class QueueClientResque < QueueClient
			# Initializes default values of socket header
			def initialize(type_of_mode, sender, file_format)
				super
			end

			# Creates a packet and sends data to the queue server.
			# ==== Args
			# _data_ :: data to enqueue to the queue server.
			# Return
			# returns true if the packet has sent to the server
			def enqueue?(data)
				result = false

				begin
					packet = addHeader(data)

					Lgdisit.logger.info(Lgdisit.get_object_id_log(self.object_id) + "Send: " + packet)
					result = true
				rescue => exception
					result = false
					Lgdisit.logger.error(exception)	
				end

				return result
			end
	end
end
