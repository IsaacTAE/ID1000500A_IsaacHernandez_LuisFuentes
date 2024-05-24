import logging, time
from ipdi.ip.pyaip import pyaip, pyaip_init

## IP CONVOLUTIONER driver class
class convolutioner:
    ## Class constructor of IP Convolutioner driver
    #
    # @param self Object pointer
    # @param targetConn Middleware object
    # @param config Dictionary with IP Convolutioner configs
    # @param addrs Network address IP
    def __init__(self, connector, nic_addr, port, csv_file):
        ## Pyaip object
        self.__pyaip = pyaip_init(connector, nic_addr, port, csv_file)

        if self.__pyaip is None:
            logging.debug(error)

        ## Array of strings with information read
        self.dataRX = []

        ## IP Convolutioner IP-ID
        self.IPID = 0

        self.__getID()

        self.__clearStatus()

        logging.debug(f"IP Convolutioner controller created with IP ID {self.IPID:08x}")

    ## Write data in the IP Convolutioner input memory X
    #
    # @param self Object pointer
    # @param data String array with the data to write
    def __writeDataX__(self, data):
        self.sizeDataX = len(data)
        self.__pyaip.writeMem('MMemX', data, len(data), 0)

        logging.debug("Data captured in MemX In")

    ## Write data in the IP Convolutioner input memory Y
    #
    # @param self Object pointer
    # @param data String array with the data to write
    def __writeDataY__(self, data):
        self.sizeDataY = len(data)
        self.__pyaip.writeMem('MMemY', data, len(data), 0)

        logging.debug("Data captured in MemY In")

    ## Read data from the IP Convolutioner output memory
    #
    # @param self Object pointer
    # @param size Amount of data to read
    def __readData__(self, size):
        data = self.__pyaip.readMem('MMemOut', size, 0)
        logging.debug("Data obtained from Mem Out")
        return data

    ## Start processing in IP Convolutioner
    #
    # @param self Object pointer
    def __startIP__(self):
        self.__pyaip.start()

        logging.debug("Start sent")

    ## Set and enable delay in IP Convolutioner processing
    #
    # @param self Object pointer
    # @param msec Delay in millisecond
    def __configurationRegister__(self, dataSizeX, dataSizeY):
        confRegSize = dataSizeX * dataSizeY

        self.__pyaip.writeConfReg('CConfReg', confRegSize, 1, 0)

        logging.debug(f"Configuration Register size is {confRegSize} ms")

    ## Enable IP Convolutioner interruptions
    #
    # @param self Object pointer
    def __enableINT__(self):
        self.__pyaip.enableINT(0, None)

        logging.debug("Int enabled")

    ## Disable IP Convolutioner interruptions
    #
    # @param self Object pointer
    def __disableINT__(self):
        self.__pyaip.disableINT(0)

        logging.debug("Int disabled")

    ## Show IP Convolutioner status
    #
    # @param self Object pointer
    def __status__(self):
        status = self.__pyaip.getStatus()
        logging.info(f"{status:08x}")

        ## Show IP Convolutioner status
        #
        # @param self Object pointer
        def status(self):
            status = self.__pyaip.getStatus()
            logging.info(f"{status:08x}")

    ## Finish connection
    #
    # @param self Object pointer
    def __finish__(self):
        self.__pyaip.finish()

    ## Wait for the completion of the process
    #
    # @param self Object pointer
    def __waitInt__(self):
        waiting = True

        while waiting:

            status = self.__pyaip.getStatus()

            logging.debug(f"status {status:08x}")

            if status & 0x1:
                waiting = False

            time.sleep(0.1)

    ## Get IP ID
    #
    # @param self Object pointer
    def __getID__(self):
        self.IPID = self.__pyaip.getID()

    ## Clear status register of IP Convolutioner
    #
    # @param self Object pointer
    def __clearStatus__(self):
        for i in range(8):
            self.__pyaip.clearINT(i)

    def conv(self, X, Y):
        if len(X) == 0 or len(Y) == 0:
            logging.info("Data X and Data Y can't be empty list")
        if len(X) > 32 or len(Y) > 32:
            logging.info("Data X and Data Y can't be higher than 32")

        self.__writeDataX__(X)
        self.__writeDataY__(Y)

        self.__configurationRegister__(len(X),len(Y))
        self.__startIP__()

        self.__waitInt__()

        result_size = len(X) + len (Y) - 1
        conv_res = self.__readData__(result_size)

        return conv_res


if __name__ == "__main__":
    import sys, random, time, os

    logging.basicConfig(level=logging.DEBUG)
    connector = '/dev/ttyACM0'
    csv_file = '/home/lagisaurio/Documents/Quartus/Convo_New/AIP_Generated/ID1000500A_config.csv'
    addr = 1
    port = 0
    aip_mem_size = 32 #Originalmente 8

    try:
        conv = convolutioner(connector, addr, port, csv_file)
        logging.info("Test Convolutioner: Driver created")
    except:
        logging.error("Test Convolutioner: Driver not created")
        sys.exit()

    random.seed(1)

    X = [random.randrange(2**32) for i in range(0, aip_mem_size)]
    Y = [random.randrange(2 ** 32) for i in range(0, aip_mem_size)]

    try:
        result = conv.conv(X,Y)
        logging.info(f"Convolution result: {[f'{x:08x}' for x in result]}")
    except Exception as e:
        logging.error(f"Error in convlution {str(e)}")
    conv.__finish__()
    logging.info("The End")
