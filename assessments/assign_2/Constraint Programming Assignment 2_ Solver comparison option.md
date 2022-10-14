---
tags: cp, cp_2022, teaching, assessment
---

# Constraint Programming Assignment 2: Solver comparison option

This assignment is worth 20% of your final grade, and is marked out of 40 marks.  It must be submitted on Moodle by 4:30 pm on Tuesday 8th November.  

If you choose the solver comparison option you must implement models for the firefighter problem in both a MiniZinc CSP style and an integer program style, as well as set up an experimental pipeline to compare them, including generating inputs, and plotting timing outputs.  You will submit a maximum 2-page report describing your efforts. Fuller details below.  

## Assignment spec
You will implement two models for the Firefighter problem as we discussed it in lecture.  You should implement both:
1. a MiniZinc CSP model, and 
2. an integer linear program model

You should then implement an experimental pipeline to compare the performance of these two models on the same set of instances, including:
- code to generate inputs for your experiments and/or use benchmark instances.
- code to test your models by passing the inputs to your models with their solvers and record the time it takes to solve them
- code to generate a plot or a table that clearly compares the performances of your two models with their solvers.  (recall we talked over a good style of plot for this in an afternoon session)

You may choose any package or solver for your integer linear program.  You may choose to run your MiniZinc model from a command line or IDE (though an IDE may make the timing pipeline challenging), or you may use the bindings available for MiniZinc within another language (e.g. https://minizinc-python.readthedocs.io/en/latest/getting_started.html).  

You must submit your models, any code you used to manage your experimental pipeline, and a short report.  I will mark mainly the report, but the code must be present for you to receive non-zero marks on this assessment. 


### Report
Your report should be at most 2 pages, and should be submitted as a PDF file.  **Please don't send me Word files.**  

Your report should start with a title that states the assignment name and course, and then your student number.  Please don't include your name.  

Your report should include the following sections:
- **MiniZinc CSP model**
    - This should describe your CSP model, and any design choices you made (e.g. what are your decision variables, any unusual constraint choices, how your model is run).  You should say which solver you use. 
- **Integer linear program model**
    - This should describe your ILP model, and any design choices you made (e.g. what your variables mean, hot to interpret them, very briefly what your constraints mean, what solver or package you use and why)
- **Instance generation or sourcing**
    - This should describe how you generated your instances (or where you got them if you foudn them ready-made) and any characteristics of them that you think is important - for example, if you generate graphs how did you chose which kind, and if different kinds how do they differ?  If you use benchmark instances mention it here and where you got your benchmarks.  
- **Experimental pipeline**
    - Describe how you set up your experiments: did you run the whole thing within Python/Java.some other language?  Or run things from a command line?  (either choice is fine, but explain why you chose what you did).  How do you run your experiments? Are there any limitations in your setup? Note that I know people will have limited computation, and this is totally fine!  I just want you to describe any limitations - if you have to run on your own laptop when say that and say what limitations this might cause.
- **Results**
    - This should describe (perhaps with a plot like the one we saw in class or a table) the timing results from your two model implementations, and describe when one model outperforms the other, if this happens.  
- **Acknowledgements:**
    - Here you should acknowledge any of your peers who you worked extensively with in learning the material for the assignment.  
- **(Optional) Bonus bit**:
    - Here you can describe any efforts on the bonus points bit - see the marking scheme for details. 


### Learning with your peers
It is perfectly fine for you to discuss your assignment work in general with your fellow students, but as usual your code and report must ultimately be your own work.  If you do work extensively with other students while devising your code, please acknowledge this collaboration in your report.  As a rough guide: a 5 minute conversation about the assignment wouldn't need an acknowledgement, but sitting together while working on code or getting debugging help would. 

If there is doubt about a submission being very similar to another, I may ask you to talk to me about the topic in person so that I can verify that the submission is your own work, and that you understand the code and report.  Please don't be alarmed if this happens.  


## Marking Scheme
Recall that this assignment is marked out of **40 total marks**
- MiniZinc CSP model: **10 marks**
    - Does the model appear to be correct?
    - Is the model reasonably described in the report, with interpretation of decision variables and any other choices made clear?
    - Is there mention of the solver used?
- Integer linear program model: **10 marks**
    - Does the model appear to be correct?
    - Is the model reasonably described in the report, with interpretation of variables, constraints and any other choices made clear?
    - Is the choice of solver mentioned and justified (by e.g. efficiency, curiosity, convenience)?
- Instance generation: **5 marks**
    - Is it clear how instances were generated?
    - Are choices about what instances to generate and how sound and well-described?
    - Are the instances varied appropriately or otherwise well-chosen?
    - If benchmark instances are used is this mentioned and source given?
- Experimental pipeline: **5 marks**
    - Is the pipeline described in reasonable detail for reproducability?
    - Does the pipeline sensibly take instances, run the models, and record timing results?
    - Are any choices of how to design the pipeline described?  Scripts, bash, within-language calls, etc?
    - Is a timeout set, and are timeouts recorded?
- Results: **10 marks**
    - Is the figure or table appropriate, readable, informative?
    - Is it clear how the solvers compare in performance?
    - Does the student deal with timeouts appropriately, and is it clear how this is done?
    - Does the text clearly interpret the results, talking about what we can understand from the results about the solvers, perhaps in different types of instances?

### Bonus 2 marks - Clever CSP modelling
The emphasis on marking for the CSP model for the main part of this assignment is on producing a reasonably-efficient correct model - I am not expecting clever insights into the CSP encoding that speed things up.  

However, up to 2 bonus marks are available if you want to try some clever or unusual encoding that might speed up computation of the MiniZinc model, and then in just a few sentences describe why you tried what you did at the end of the report.  
- You can get up to 2 extra bonus marks for this extra bit, though your total mark is capped at 40 marks.  For example: even if with bonus marks your mark was 42 marks, you would only get a final grade of 40 marks.
