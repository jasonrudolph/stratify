# In production, rake tasks don't reliably flush the logging buffer to the
# log file before exiting the rake task.  Here, we work around that defect.
#
# See https://rails.lighthouseapp.com/projects/8994/tickets/543
at_exit { Rails.logger.flush }
