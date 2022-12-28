# program to run Species and MLST

# Extract filenames which ends with ".fasta" under "Plasmids" folder
SAMPLES, = glob_wildcards('Plasmids/{name}.fasta') 

# For code clarity, this variable "prokka_output" is used in rule_all ( see line 13: where we use only "prokka_output" variable instead of whole path)
prokka_output = '2_PROKKA/{sample}_prokka_out/{sample}.gff'

# The input for rule all is the final output of rules in the pipeline. 
# If there are multiple files, then it should be written inside expand command.

# For example, below I have typed "expand(prokka_output, sample=SAMPLES)" which means it will check the final output if 
# there are "2_PROKKA/{sample}_prokka_out/{sample}.gff" files created for the rule "run_PROKKA".

rule all:
  input: 
    "1_MLST/mlst_log", 
    expand(prokka_output, sample=SAMPLES), # Since this output have many files we use expand command
    expand('3_ROARY/{sample}.gff', sample=SAMPLES),  
    "3_ROARY/3_ROARY_OUTPUT/summary_statistics.txt" # Since this output does not have many files
    
 # Then comes all other rules     

rule run_MLST:
    input: expand("Plasmids/{sample}.fasta", sample=SAMPLES) # Need to specify assemblies with a wildcard
    output: "1_MLST/mlst_log" # Need to specify MLST output with a wildcard and this is the output we have given in rule all
    shell: "mlst {input} >> {output}"

rule run_PROKKA:
    input: expand("Plasmids/{sample}.fasta", sample=SAMPLES) # Need to specify assemblies with a wildcard
    output: 
      "2_PROKKA/{sample}_prokka_out/{sample}.gff"
    threads: 32
    shell: "prokka2 --force --cpus {threads} --outdir 2_PROKKA/{wildcards.sample}_prokka_out --prefix {wildcards.sample} {input} >>2_PROKKA/prokka_log 2>>2_PROKKA/prokka_error"

rule cp_PROKKA_gffs:
  input: expand("2_PROKKA/{sample}_prokka_out/{sample}.gff", sample=SAMPLES)
  params:
    outdir= "3_ROARY" # For some reason instead of using {output}, using {params.outdir} worked in shell command
  output: "3_ROARY/{sample}.gff" # Need to specify ROARY output and this is the output we have given in rule all
  shell: "cp {input} {params.outdir}"

rule run_ROARY:
    input: expand("3_ROARY/{sample}.gff", sample=SAMPLES) # Need to specify gffs with a wildcard
    output: "3_ROARY/3_ROARY_OUTPUT/summary_statistics.txt" # Need to specify ROARY output and this is the output we have given in rule all 
    params:
      outdir = "3_ROARY/3_ROARY_OUTPUT"
    shell:
      'roary -f {params.outdir} -p 48 {input}'

