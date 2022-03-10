 ### Installed nextflow - No issue with Nextflow installation
 
 ```
 $ nextflow run epi2me-labs/wf-artic --help

N E X T F L O W  ~  version 21.04.3

Launching `epi2me-labs/wf-artic` [nice_stone] - revision: d875912881 [master]

Typical pipeline command:



  nextflow run epi2me-labs/wf-artic --fastq <input folder>-profile docker



Basic Input/Output Options

  --out_dir                [string]  Directory for output of all user-facing files. [default: output]

  --fastq                  [string]  A fastq file or directory containing fastq input files or directories of input files.

  --sample                 [string]  A sample name for non-multiplexed data. Permissible if passing a file or directory of .fastq(.gz).

  --sample_sheet           [string]  CSV file with columns named `barcode`, `sample_id` and `type`. Permissible if passing a directory containing barcodeXX 

                                     sub-directories. 

  --genotype_variants      [string]  Report genotyping information for scheme's known variants of interest, optionally provide file path as argument.

  --sanitize_fastq         [boolean] Use additional heuristics to identify barcodes from file paths.
```

But error on running nextflow command
 

```
$ nextflow run epi2me-labs/wf-artic -w workspace -profile standard --fastq /data01/Nanopore_data_ARTIC/wf-artic/test_data/sars-samples-demultiplexed --samples /data01/Nanopore_data_ARTIC/wf-artic/test_data/sample_sheet --out_dir /data01/Nanopore_data_ARTIC/wf-artic/test_data/out
N E X T F L O W  ~  version 21.04.3
Launching `epi2me-labs/wf-artic` [hopeful_stonebraker] - revision: d875912881 [master]

WARN: Found unexpected parameters:
* --samples: /data01/Nanopore_data_ARTIC/wf-artic/test_data/sample_sheet
- Ignore this warning: params.schema_ignore_params = "samples" 

Core Nextflow options
  revision       : master
  runName        : hopeful_stonebraker
  containerEngine: docker
  launchDir      : /data01/Nanopore_data_ARTIC
  workDir        : /data01/Nanopore_data_ARTIC/workspace
  projectDir     : /home/prakki/.nextflow/assets/epi2me-labs/wf-artic
  userName       : prakki
  profile        : standard
  configFiles    : /home/prakki/.nextflow/assets/epi2me-labs/wf-artic/nextflow.config

Basic Input/Output Options
  out_dir        : /data01/Nanopore_data_ARTIC/wf-artic/test_data/out
  fastq          : /data01/Nanopore_data_ARTIC/wf-artic/test_data/sars-samples-demultiplexed

Advanced options
  normalise      : 200

!! Only displaying parameters that differ from the pipeline defaults !!
------------------------------------------------------
If you use wf-artic for your analysis please cite:

* The nf-core framework
  https://doi.org/10.1038/s41587-020-0439-x



Checking fastq input.
Barcoded directories detected.
Warning: Excluding directories not containing .fastq(.gz) files:
   - /data01/Nanopore_data_ARTIC/wf-artic/test_data/sars-samples-demultiplexed/barcode13
executor >  local (5)
[-        ] process > pipeline:getVersions    [  0%] 0 of 1
executor >  local (5)
[-        ] process > pipeline:getVersions    [  0%] 0 of 1
[-        ] process > pipeline:getParams      -
[83/7ff31a] process > pipeline:copySchemeDir  [100%] 1 of 1, failed: 1 ✘
[b3/d240e0] process > pipeline:preArticQC (2) [100%] 2 of 2, failed: 2 ✘
[-        ] process > pipeline:runArtic       -
[-        ] process > pipeline:combineDepth   -
[-        ] process > pipeline:allConsensus   -
[-        ] process > pipeline:allVariants    -
[f6/6cea26] process > pipeline:prep_nextclade [100%] 1 of 1, failed: 1 ✘
[-        ] process > pipeline:nextclade      -
[-        ] process > pipeline:pangolin       -
[-        ] process > pipeline:telemetry      -
[-        ] process > pipeline:report         -
[-        ] process > output                  -
Error executing process > 'pipeline:preArticQC (1)'

Caused by:
  Process `pipeline:preArticQC (1)` terminated with an error exit status (126)

Command executed:

  fastcat -s barcode02 -r barcode02.stats -x barcode02 > /dev/null

Command exit status:
  126

Command output:
  (empty)

Command error:
  docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/create?name=nxf-8ToINIH3jAkv8ZB3J6ewd7tS": dial unix /var/run/docker.sock: connect: permission denied.
  See 'docker run --help'.

Work dir:
  /data01/Nanopore_data_ARTIC/workspace/53/44f51e22aba796b71c6125b88b42c3

Tip: when you have fixed the problem you can continue the execution adding the option `-resume` to the run command line
```
### Installing docker -ended with error
```
$ sudo apt install docker.io
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 docker.io : Depends: containerd (>= 1.2.6-0ubuntu1~)
E: Unable to correct problems, you have held broken packages.
```
### Resintalled docker by following commands

```
$ dpkg -l containerd*
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-======================================
un  containerd     <none>       <none>       (no description available)
ii  containerd.io  1.4.9-1      amd64        An open and reliable container runtime

$ sudo apt install containerd
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  runc
The following packages will be REMOVED:
  containerd.io docker-ce
The following NEW packages will be installed:
  containerd runc
0 upgraded, 2 newly installed, 2 to remove and 198 not upgraded.
Need to get 37.1 MB of archives.
After this operation, 47.1 MB disk space will be freed.
Do you want to continue? [Y/n] Y

$ sudo apt install docker.io

$ sudo apt-get install docker.io
Reading package lists... Done
Building dependency tree       
Reading state information... Done
docker.io is already the newest version (20.10.7-0ubuntu5~20.04.2).
0 upgraded, 0 newly installed, 0 to remove and 197 not upgraded.
```
### Installing wf-artic
```
git clone https://github.com/epi2me-labs/wf-artic
```

### Run the pipeline with the test data using `profile conda` did not work

```
nextflow run epi2me-labs/wf-artic -w workspace -profile conda --fastq /data01/Nanopore_data_ARTIC/wf-artic/test_data/sars-samples-demultiplexed --samples /data01/Nanopore_data_ARTIC/wf-artic/test_data/sample_sheet --out_dir /data01/Nanopore_data_ARTIC/wf-artic/test_data/out

```

### Run the pipeline with the test data using `profile standard` resulted in error
```
$ nextflow run epi2me-labs/wf-artic --help
N E X T F L O W  ~  version 21.04.3
Launching `epi2me-labs/wf-artic` [pensive_boyd] - revision: d875912881 [master]
Typical pipeline command:

  nextflow run epi2me-labs/wf-artic --fastq <input folder>-profile docker

Basic Input/Output Options
  --out_dir                [string]  Directory for output of all user-facing files. [default: output]
  --fastq                  [string]  A fastq file or directory containing fastq input files or directories of input files.
  --sample                 [string]  A sample name for non-multiplexed data. Permissible if passing a file or directory of .fastq(.gz).
  --sample_sheet           [string]  CSV file with columns named `barcode`, `sample_id` and `type`. Permissible if passing a directory containing barcodeXX 
                                     sub-directories. 
  --genotype_variants      [string]  Report genotyping information for scheme's known variants of interest, optionally provide file path as argument.
  --sanitize_fastq         [boolean] Use additional heuristics to identify barcodes from file paths.

OUTPUT=my_artic_output nextflow run epi2me-labs/wf-artic -w ${OUTPUT}/workspace -profile standard --fastq test_data/sars-samples-demultiplexed/ --samples test_data/sample_sheet --out_dir ${OUTPUT}

$ OUTPUT=my_artic_output nextflow run /data01/Nanopore_data_ARTIC/wf-artic -w ${OUTPUT}/workspace -profile standard --fastq /data01/Nanopore_data_ARTIC/wf-artic/test_data/sars-samples-demultiplexed --samples /data01/Nanopore_data_ARTIC/wf-artic/test_data/sample_sheet --out_dir ${OUTPUT}

Checking fastq input.
Barcoded directories detected.
Warning: Excluding directories not containing .fastq(.gz) files:
   - /data01/Nanopore_data_ARTIC/wf-artic/test_data/sars-samples-demultiplexed/barcode13
executor >  local (5)
[76/a51c8d] process > pipeline:getVersions    [  0%] 0 of 1
executor >  local (5)
[76/a51c8d] process > pipeline:getVersions    [100%] 1 of 1, failed: 1 ✘
[d1/9a6db8] process > pipeline:getParams      [100%] 1 of 1, failed: 1 ✘
[7f/5c7ec2] process > pipeline:copySchemeDir  [100%] 1 of 1, failed: 1 ✘
[6b/962460] process > pipeline:preArticQC (1) [  0%] 0 of 1
[-        ] process > pipeline:runArtic       -
[-        ] process > pipeline:combineDepth   -
[-        ] process > pipeline:allConsensus   -
[-        ] process > pipeline:allVariants    -
[e0/1be7b8] process > pipeline:prep_nextclade [100%] 1 of 1, failed: 1 ✘
[-        ] process > pipeline:nextclade      -
[-        ] process > pipeline:pangolin       -
[-        ] process > pipeline:telemetry      -
[-        ] process > pipeline:report         -
[-        ] process > output                  -
Error executing process > 'pipeline:getVersions'
```

As per the users (https://github.com/nf-core/atacseq/issues/54#issuecomment-545395764), this kind of error is due to Nextflow is unable to use the software in the container.

# Started the docker - successfully worked!
```
$ systemctl start docker

time nextflow run epi2me-labs/wf-artic -w WD -profile standard --fastq /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed --samples /data01/Nanopore_data_ARTIC/artic/test_data/sample_sheet --out_dir test_data_output
N E X T F L O W  ~  version 21.04.3
Launching `epi2me-labs/wf-artic` [soggy_legentil] - revision: d875912881 [master]

WARN: Found unexpected parameters:
* --samples: /data01/Nanopore_data_ARTIC/artic/test_data/sample_sheet
- Ignore this warning: params.schema_ignore_params = "samples" 

Core Nextflow options
  revision       : master
  runName        : soggy_legentil
  containerEngine: docker
  launchDir      : /data01/Nanopore_data_ARTIC/artic
  workDir        : /data01/Nanopore_data_ARTIC/artic/WD
  projectDir     : /home/prakki/.nextflow/assets/epi2me-labs/wf-artic
  userName       : prakki
  profile        : standard
  configFiles    : /home/prakki/.nextflow/assets/epi2me-labs/wf-artic/nextflow.config

Basic Input/Output Options
  out_dir        : test_data_output
  fastq          : /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed

Advanced options
  normalise      : 200

!! Only displaying parameters that differ from the pipeline defaults !!
------------------------------------------------------
If you use wf-artic for your analysis please cite:

* The nf-core framework
  https://doi.org/10.1038/s41587-020-0439-x



Checking fastq input.
Barcoded directories detected.
Warning: Excluding directories not containing .fastq(.gz) files:
   - /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed/barcode13
executor >  local (33)
[9e/7b3c20] process > pipeline:getVersions    [100%] 1 of 1 ✔
[d6/ab2c59] process > pipeline:getParams      [100%] 1 of 1 ✔
[70/b94054] process > pipeline:copySchemeDir  [100%] 1 of 1 ✔
[91/d46d05] process > pipeline:preArticQC (2) [100%] 2 of 2 ✔
[44/1ccb10] process > pipeline:runArtic (1)   [100%] 2 of 2 ✔
[97/180591] process > pipeline:combineDepth   [100%] 1 of 1 ✔
[b7/950a0d] process > pipeline:allConsensus   [100%] 1 of 1 ✔
[fd/414e60] process > pipeline:allVariants    [100%] 1 of 1 ✔
[54/bb60dc] process > pipeline:prep_nextclade [100%] 1 of 1 ✔
[64/8ec5d3] process > pipeline:nextclade      [100%] 1 of 1 ✔
[ee/06ee81] process > pipeline:pangolin       [100%] 1 of 1 ✔
[88/74e10d] process > pipeline:telemetry      [100%] 1 of 1 ✔
[15/a88236] process > pipeline:report         [100%] 1 of 1 ✔
[c3/9e9d6d] process > output (15)             [100%] 18 of 18 ✔
Completed at: 10-Mar-2022 11:50:13
Duration    : 24m 54s
CPU hours   : 0.5
Succeeded   : 33



real	24m58.302s
user	1m15.834s
sys	0m10.498s

```
### While running the nextflow pipeline in another tab running following command shows the pipeline running without issues
```
$ docker ps -a
CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS         PORTS     NAMES
1c1e39722ce8   ontresearch/wf-artic:v0.3.12   "/bin/bash -c 'eval …"   5 minutes ago   Up 5 minutes             nxf-KJc4qbq1cG9gy7Y2eqMC3nmf
c0466175b8e8   ontresearch/wf-artic:v0.3.12   "/bin/bash -c 'eval …"   5 minutes ago   Up 5 minutes             nxf-JXPFTJPVgds7RE0LYpWDKiW5

```
### In the nextflow.config, changed the following parameters to fasten the process.:

`executor {
    $local {
        cpus = 60
        memory = "256 GB"
    }
}`

### The time difference is remarkable! 24 mins to 7 mins as shown below

```
time nextflow run epi2me-labs/wf-artic -w WD_cpe_60_mem_256gb -profile standard --fastq /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed --samples /data01/Nanopore_data_ARTIC/artic/test_data/sample_sheet --out_dir test_data_output_cpe_60_mem_256gb/
N E X T F L O W  ~  version 21.04.3
Launching `epi2me-labs/wf-artic` [infallible_lumiere] - revision: d875912881 [master]

WARN: Found unexpected parameters:
* --samples: /data01/Nanopore_data_ARTIC/artic/test_data/sample_sheet
- Ignore this warning: params.schema_ignore_params = "samples" 

Core Nextflow options
  revision       : master
  runName        : infallible_lumiere
  containerEngine: docker
  launchDir      : /data01/Nanopore_data_ARTIC/artic
  workDir        : /data01/Nanopore_data_ARTIC/artic/WD_cpe_60_mem_256gb
  projectDir     : /home/prakki/.nextflow/assets/epi2me-labs/wf-artic
  userName       : prakki
  profile        : standard
  configFiles    : /home/prakki/.nextflow/assets/epi2me-labs/wf-artic/nextflow.config

Basic Input/Output Options
  out_dir        : test_data_output_cpe_60_mem_256gb/
  fastq          : /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed

Advanced options
  normalise      : 200

!! Only displaying parameters that differ from the pipeline defaults !!
------------------------------------------------------
If you use wf-artic for your analysis please cite:

* The nf-core framework
  https://doi.org/10.1038/s41587-020-0439-x



Checking fastq input.
Barcoded directories detected.
Warning: Excluding directories not containing .fastq(.gz) files:
   - /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed/barcode13
executor >  local (33)
[d5/781c3c] process > pipeline:getVersions    [100%] 1 of 1 ✔
[6a/be8d39] process > pipeline:getParams      [100%] 1 of 1 ✔
[72/b2218c] process > pipeline:copySchemeDir  [100%] 1 of 1 ✔
[77/4e2572] process > pipeline:preArticQC (1) [100%] 2 of 2 ✔
[ca/92c2cc] process > pipeline:runArtic (2)   [100%] 2 of 2 ✔
[f7/464004] process > pipeline:combineDepth   [100%] 1 of 1 ✔
[01/b4e495] process > pipeline:allConsensus   [100%] 1 of 1 ✔
[6e/64a3e7] process > pipeline:allVariants    [100%] 1 of 1 ✔
[66/5ea2b9] process > pipeline:prep_nextclade [100%] 1 of 1 ✔
[fc/98bbad] process > pipeline:nextclade      [100%] 1 of 1 ✔
[e6/0a925b] process > pipeline:pangolin       [100%] 1 of 1 ✔
[d2/db35e0] process > pipeline:telemetry      [100%] 1 of 1 ✔
[89/039353] process > pipeline:report         [100%] 1 of 1 ✔
[f2/73b3a9] process > output (17)             [100%] 18 of 18 ✔
Completed at: 10-Mar-2022 12:01:49
Duration    : 7m 40s
CPU hours   : 0.4
Succeeded   : 33



real	7m44.442s
user	1m9.121s
sys	0m8.066s

```




















