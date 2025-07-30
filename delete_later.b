import servicemanager
import socket
import sys
import win32event
import win32service
import win32serviceutil

class SimpleFileService(win32serviceutil.ServiceFramework):
    _svc_name_ = "SimpleFileService"
    _svc_display_name_ = "Simple File Service"
    _svc_description_ = "A simple service that writes to a file when started"

    def __init__(self, args):
        win32serviceutil.ServiceFramework.__init__(self, args)
        self.hWaitStop = win32event.CreateEvent(None, 0, 0, None)
        socket.setdefaulttimeout(60)

    def SvcStop(self):
        # Write "service stopped" when service stops
        try:
            with open('C:\\service_status.txt', 'a') as f:
                f.write('\nservice stopped')
        except:
            pass
        
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        win32event.SetEvent(self.hWaitStop)

    def SvcDoRun(self):
        # Check if this is a restart by looking for existing file
        restart = False
        try:
            with open('C:\\service_status.txt', 'r') as f:
                if 'service started' in f.read():
                    restart = True
        except:
            pass
        
        # Write appropriate start message
        try:
            mode = 'a' if restart else 'w'
            with open('C:\\service_status.txt', mode) as f:
                if restart:
                    f.write('\nservice restarted')
                else:
                    f.write('service started')
        except:
            pass
        
        rc = None
        while rc != win32event.WAIT_OBJECT_0:
            rc = win32event.WaitForSingleObject(self.hWaitStop, 5000)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        servicemanager.Initialize()
        servicemanager.PrepareToHostSingle(SimpleFileService)
        servicemanager.StartServiceCtrlDispatcher()
    else:
        win32serviceutil.HandleCommandLine(SimpleFileService)
