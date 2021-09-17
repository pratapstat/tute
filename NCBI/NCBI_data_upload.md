# Pointers:

1. Always best to create a bioproject first and get PRJNA number
2. Then create a BioSample project - in the Microbe1.0 excel provide the Bioproject (PRJNA) number
3. Then do the SRA submission.
4. For the SRA submission, if you have two types of data such as Ilumina and Nanopore sequences for the same sample, then in the SRA_meta_acc file
have the Illumina information and followed by nanopore details. 
5. The SAM number (Biosample number) will be same for both Illumina and Nanopore data
6. If your data samples are more than 1000, then submission is not possible in NCBI. SO you have to split the data accordingly.
7. If your data samples are less than 1000, but if you have two types of data such as Illumina and Nanopore for n=600 samples, then it is better to split into 
two SRA_meta_acc files since NCBI does not allow meta_data more than 1000 records. Because here 600\*2 becomes 1200 records.
8. aspera command line seems a bit confusing to use, ftp seems to be straightforward. Just need to get username password from SRA submission
9. Advantage with ftp is: Even if sometimes the internet connection drops, we can resume from where transfer stopped
10. We cannot upload half of our data with FTP and half of our data aspera. It is either aspera or FTP. 



$ ftp -i 
ftp> open ftp-private.ncbi.nlm.nih.gov
Connected to ftp-private.wip.ncbi.nlm.nih.gov.

220-

 This warning banner provides privacy and security notices consistent with 
 applicable federal laws, directives, and other federal guidance for accessing 
 this Government system, which includes all devices/storage media attached to 
 this system. This system is provided for Government-authorized use only. 
 Unauthorized or improper use of this system is prohibited and may result in 
 disciplinary action and/or civil and criminal penalties. At any time, and for 
 any lawful Government purpose, the government may monitor, record, and audit 
 your system usage and/or intercept, search and seize any communication or data 
 transiting or stored on this system. Therefore, you have no reasonable 
 expectation of privacy. Any communication or data transiting or stored on this 
 system may be disclosed or used for any lawful Government purpose.

220 FTP Server ready.
Name (ftp-private.ncbi.nlm.nih.gov:prakki): blabla

331 Password required for blabla

230 User blabla logged in
Remote system type is UNIX.
Using binary mode to transfer files.

ftp> cd uploads/my_gmail.com_blabla
250 CWD command successful

ftp> mkdir Prj_Ill
257 "/uploads/my_gmail.com_blabla/Prj_Ill" - Directory successfully created

ftp> cd CPE_Trans_Prj_Ill
250 CWD command successful

ftp> mput \*.fastq.gz
