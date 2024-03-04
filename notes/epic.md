# Epic on FHIR

Create app step-by-step:
https://fhir.epic.com/Documentation?docId=epiconfhirrequestprocessstepbystep

OAuth2 Documentation:
https://fhir.epic.com/Documentation?docId=oauth2

Epic also has a token inspection endpoint:
https://fhir.epic.com/Specifications?api=488


Application flow:
1. Render Epic Wrapper App with the patient FHIR id passed in the URL
    * There needs to be some kind of auth flow here
2. Make request Epic's FHIR resource for patient information
3. Parse response and send patient information to Aledade patient matching
4. With returned patient, render the POC iFrame


Only actions in DH that really have write effects on the DB are DX suggestions.
Everything else should probs work to hide redundant data already displayed
in the EHR (if that is something that we want to do).

Data shown in the patient draw compact and their related FHIR resources:
1. Dx Suggestions
    * Adds encounter diagnoses to patients chart: [https://fhir.epic.com/Specifications?api=1058]
2. Care gaps
3. Hospital Events
4. Medication aherence
5. Specialist Utilization
6. Preventive Services
7. Appointment Information
8. Patient Tags

Etc...

There is also a longitudinal management plan:
1. https://fhir.epic.com/Specifications?api=1064


Some FHIR groupings:
1. Problem List
    * Pull diagnosis data from problem list [https://fhir.epic.com/Specifications?api=468]
    * Read high level concernts from problems list [https://fhir.epic.com/Specifications?api=10197]
    * Read directly from problem list [https://fhir.epic.com/Specifications?api=10144]
2. Demographic Information: [https://fhir.epic.com/Specifications?api=931]
3. Bulk data retreival
4. Medical document handoffs, lab reports
5. Medication, Service, and Procedure requests
6. Get information on a patient's devices (implants, external)
7. Encounter information
8. Patient health goals
9. Immunization
10. Observations about the patient randing from genomics to family situation



**FINAL**

Aledade's plan for Epic on FHIR is to imbed the patient drawer in Epic.

The patient drawer surfaces several insights
1. Dx Suggestions
2. Care gaps
3. Hospital Events
4. Medication Aherence Concerns
5. Specialist Utilization
6. Preventive Services
7. Appointment Information
8. Patient Tags
Etc..

From these, ther
