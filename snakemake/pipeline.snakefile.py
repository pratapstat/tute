# program to run Species and MLST

# Extract filenames which ends with ".fasta" under "Plasmids" folder
SAMPLES, = glob_wildcards('Plasmids/{name}.fasta') 

# For code clarity, this variable "prokka_output" is used in rule_all
prokka_output = '2_PROKKA/{sample}_prokka_out/{sample}.gbk'

# The input for rule all is the final output of the pipeline. If rules are not interconnected then the corresponding rule's output should be copied here.
# If there are multiple files, then it should be written inside expand command as i have done.

# For example, below I have typed "expand(prokka_output, sample=SAMPLES)" which means it will check the final output if 
# there are "2_PROKKA/{sample}_prokka_out/{sample}.gbk" files created.

rule all:
  input: "1_MLST/mlst_log", expand(prokka_output, sample=SAMPLES), expand("3_ROARY/{sample}.gff", sample=SAMPLES)

# Then comes all other rules  
  
rule run_MLST:
    input: expand("Plasmids/{sample}.fasta", sample=SAMPLES) # Need to specify contig files using a wildcard
    output: "1_MLST/mlst_log" # Need to specify MLST output. Since I want everything to be combined into one output file, I concatenate
    shell: "mlst {input} >> {output}"

rule run_PROKKA:
    input: expand("Plasmids/{sample}.fasta", sample=SAMPLES) # Need to specify contig files using a wildcard for Prokka
    output: 
      "2_PROKKA/{sample}_prokka_out/{sample}.gbk" # This is my output directories of all the samples using prokka 
    threads: 32
    shell: "prokka2 --force --cpus {threads} --outdir 2_PROKKA/{wildcards.sample}_prokka_out --prefix {wildcards.sample} {input} >>2_PROKKA/prokka_log 2>>2_PROKKA/prokka_error"

      
# Copy the gff files into a folder (need to work)      
      
rule cp_gff:
  input: expand("2_PROKKA/{sample}_prokka_out/{sample}.gff", sample=SAMPLES) 
  output: "3_ROARY/{sample}.gff"
  shell: "cp {input} 3_ROARY"
    
 # Run Roary   

...
    
    
