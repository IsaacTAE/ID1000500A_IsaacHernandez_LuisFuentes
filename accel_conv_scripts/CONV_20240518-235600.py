from ipdi.ip.pyaip import pyaip, pyaip_init

import sys

try:
    connector = '/dev/ttyACM0'
    nic_addr = 1
    port = 0
    csv_file = '/home/lagisaurio/Documents/Quartus/Convolucionador-AIP_Generator_File/HDL/ID40048008/config/ID40048008_config.csv'

    aip = pyaip_init(connector, nic_addr, port, csv_file)

    aip.reset()

    #==========================================
    # Code generated with IPAccelerator 

    ID = aip.getID()
    print(f'Read ID: {ID:08X}\n')

    STATUS = aip.getStatus()
    print(f'Read STATUS: {STATUS:08X}\n')

    memX_fromFile = [0x0000002C, 0x000000A1, 0x0000009B, 0x000000BF, 0x00000003, 0x00000063, 0x0000004F, 0x00000084, 0x000000C1, 0x00000091, 0x00000068, 0x00000097, 0x00000028, 0x00000086, 0x00000044, 0x00000078, 0x0000003F, 0x000000CB, 0x000000E1, 0x0000009A, 0x00000050, 0x0000009B, 0x000000B3, 0x0000005F, 0x0000007E, 0x000000A1, 0x00000024, 0x000000D9, 0x000000B5, 0x0000008C, 0x000000D9, 0x0000006A]

    print('Write memory: MMemX')
    aip.writeMem('MMemX', memX_fromFile, 32, 0)
    print(f'memX_fromFile Data: {[f"{x:08X}" for x in memX_fromFile]}\n')

    memY_fromFile = [0x000000C6, 0x0000005B, 0x000000C7, 0x000000BF, 0x000000C5, 0x000000B7, 0x000000B6, 0x000000C0, 0x0000005E, 0x0000002C, 0x00000034, 0x000000F3, 0x0000007C, 0x00000040, 0x00000079, 0x00000070, 0x00000019, 0x000000DB, 0x0000008B, 0x000000E4, 0x000000FD, 0x0000009F, 0x00000020, 0x00000075, 0x000000F0, 0x000000E6, 0x00000039, 0x0000004C, 0x0000005F, 0x000000F9, 0x00000004, 0x00000018]

    print('Write memory: MMemY')
    aip.writeMem('MMemY', memY_fromFile, 32, 0)
    print(f'memY_fromFile Data: {[f"{x:08X}" for x in memY_fromFile]}\n')

    configReg_sizeX5_sizeY10 = [0x00000145]

    print('Write configuration register: CConfReg')
    aip.writeConfReg('CConfReg', configReg_sizeX5_sizeY10, 1, 0)
    print(f'configReg_sizeX5_sizeY10 Data: {[f"{x:08X}" for x in configReg_sizeX5_sizeY10]}\n')

    print('Start IP\n')
    aip.start()

    STATUS = aip.getStatus()
    print(f'Read STATUS: {STATUS:08X}\n')

    print('Read memory: MMemOut')
    processed_Data = aip.readMem('MMemOut', 16, 0)
    print(f'processed_Data Data: {[f"{x:08X}" for x in processed_Data]}\n')

    print('Clear INT: 0')
    aip.clearINT(0)

    STATUS = aip.getStatus()
    print(f'Read STATUS: {STATUS:08X}\n')

    #==========================================

    aip.finish()

except:
    e = sys.exc_info()
    print('ERROR: ', e)

    aip.finish()
    raise
