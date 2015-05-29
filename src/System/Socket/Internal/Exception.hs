{-# LANGUAGE DeriveDataTypeable #-}
module System.Socket.Internal.Exception (
    SocketException (..)
  ) where

import Control.Concurrent.MVar
import Control.Exception

import Data.Typeable

import Foreign.Ptr
import Foreign.Storable
import Foreign.C.Error
import Foreign.Marshal.Alloc

newtype SocketException
      = SocketException Errno
  deriving Typeable

instance Exception SocketException

instance Show SocketException where
  show (SocketException e) = "SocketException " ++ strerr e
    where 
      strerr errno
        | errno == eOK             = "EOK"
        | errno == e2BIG           = "E2BIG"
        | errno == eACCES          = "EACCES"
        | errno == eADDRINUSE      = "EADDRINUSE"
        | errno == eADDRNOTAVAIL   = "EADDRNOTAVAIL"
        | errno == eADV            = "EADV"
        | errno == eAFNOSUPPORT    = "EAFNOSUPPORT"
        | errno == eAGAIN          = "EAGAIN"
        | errno == eALREADY        = "EALREADY"
        | errno == eBADF           = "EBADF"
        | errno == eBADMSG         = "EBADMSG"
        | errno == eBADRPC         = "EBADRPC"
        | errno == eBUSY           = "EBUSY"
        | errno == eCHILD          = "ECHILD"
        | errno == eCOMM           = "ECOMM"
        | errno == eCONNABORTED    = "ECONNABORTED"
        | errno == eCONNREFUSED    = "ECONNREFUSED"
        | errno == eCONNRESET      = "ECONNRESET"
        | errno == eDEADLK         = "EDEADLK"
        | errno == eDESTADDRREQ    = "EDESTADDRREQ"
        | errno == eDIRTY          = "EDIRTY"
        | errno == eDOM            = "EDOM"
        | errno == eDQUOT          = "EDQUOT"
        | errno == eEXIST          = "EEXIST"
        | errno == eFAULT          = "EFAULT"
        | errno == eFBIG           = "EFBIG"
        | errno == eFTYPE          = "EFTYPE"
        | errno == eHOSTDOWN       = "EHOSTDOWN"
        | errno == eHOSTUNREACH    = "EHOSTUNREACH"
        | errno == eIDRM           = "EIDRM"
        | errno == eILSEQ          = "EILSEQ"
        | errno == eINPROGRESS     = "EINPROGRESS"
        | errno == eINTR           = "EINTR"
        | errno == eINVAL          = "EINVAL"
        | errno == eIO             = "EIO"
        | errno == eISCONN         = "EISCONN"
        | errno == eISDIR          = "EISDIR"
        | errno == eLOOP           = "ELOOP"
        | errno == eMFILE          = "EMFILE"
        | errno == eMLINK          = "EMLINK"
        | errno == eMSGSIZE        = "EMSGSIZE"
        | errno == eMULTIHOP       = "EMULTIHOP"
        | errno == eNAMETOOLONG    = "ENAMETOOLONG"
        | errno == eNETDOWN        = "ENETDOWN"
        | errno == eNETRESET       = "ENETRESET"
        | errno == eNETUNREACH     = "ENETUNREACH"
        | errno == eNFILE          = "ENFILE"
        | errno == eNOBUFS         = "ENOBUFS"
        | errno == eNODATA         = "ENODATA"
        | errno == eNODEV          = "ENODEV"
        | errno == eNOENT          = "ENOENT"
        | errno == eNOEXEC         = "ENOEXEC"
        | errno == eNOLCK          = "ENOLCK"
        | errno == eNOLINK         = "ENOLINK"
        | errno == eNOMEM          = "ENOMEM"
        | errno == eNOMSG          = "ENOMSG"
        | errno == eNONET          = "ENONET"
        | errno == eNOPROTOOPT     = "ENOPROTOOPT"
        | errno == eNOSPC          = "ENOSPC"
        | errno == eNOSR           = "ENOSR"
        | errno == eNOSTR          = "ENOSTR"
        | errno == eNOSYS          = "ENOSYS"
        | errno == eNOTBLK         = "ENOTBLK"
        | errno == eNOTCONN        = "ENOTCONN"
        | errno == eNOTDIR         = "ENOTDIR"
        | errno == eNOTEMPTY       = "ENOTEMPTY"
        | errno == eNOTSOCK        = "ENOTSOCK"
        | errno == eNOTTY          = "ENOTTY"
        | errno == eNXIO           = "ENXIO"
        | errno == eOPNOTSUPP      = "EOPNOTSUPP"
        | errno == ePERM           = "EPERM"
        | errno == ePFNOSUPPORT    = "EPFNOSUPPORT"
        | errno == ePIPE           = "EPIPE"
        | errno == ePROCLIM        = "EPROCLIM"
        | errno == ePROCUNAVAIL    = "EPROCUNAVAIL"
        | errno == ePROGMISMATCH   = "EPROGMISMATCH"
        | errno == ePROGUNAVAIL    = "EPROGUNAVAIL"
        | errno == ePROTO          = "EPROTO"
        | errno == ePROTONOSUPPORT = "EPROTONOSUPPORT"
        | errno == ePROTOTYPE      = "EPROTOTYPE"
        | errno == eRANGE          = "ERANGE"
        | errno == eREMCHG         = "EREMCHG"
        | errno == eREMOTE         = "EREMOTE"
        | errno == eROFS           = "EROFS"
        | errno == eRPCMISMATCH    = "ERPCMISMATCH"
        | errno == eRREMOTE        = "ERREMOTE"
        | errno == eSHUTDOWN       = "ESHUTDOWN"
        | errno == eSOCKTNOSUPPORT = "ESOCKTNOSUPPORT"
        | errno == eSPIPE          = "ESPIPE"
        | errno == eSRCH           = "ESRCH"
        | errno == eSRMNT          = "ESRMNT"
        | errno == eSTALE          = "ESTALE"
        | errno == eTIME           = "ETIME"
        | errno == eTIMEDOUT       = "ETIMEDOUT"
        | errno == eTOOMANYREFS    = "ETOOMANYREFS"
        | errno == eTXTBSY         = "ETXTBSY"
        | errno == eUSERS          = "EUSERS"
        | errno == eWOULDBLOCK     = "EWOULDBLOCK"
        | errno == eXDEV           = "EXDEV"
        | otherwise                = let Errno i = errno
                                     in  show i
