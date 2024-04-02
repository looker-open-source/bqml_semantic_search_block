# Looker x GenAI BigQuery Semantic Search Block

### Description
Seamlessly integrate BigQuery's cutting-edge semantic search capabilities directly into your Looker instance. Empower users to perform dynamic, natural language similarity searches, unlocking innovative use cases on your enterprise data.

### Key Features
| Feature | Description |
| --- | --- |
| Effortless Setup | Get started quickly with well-documented installation and configuration|
| Dynamic Natural Language Queries | Grant users the ability to search across any field or combination | of fields in Looker Explores using natural language.
| Real-time Search | Receive search results in real time, enabling fast analysis and decision-making |
| Customizable | Adapt the block to your specific dataset and fine-tune search parameters as needed |

#### What is BigQuery Semantic Search?

BigQuery's semantic search employs advanced machine learning models from Vertex AI to enable similarity-based searches on your data. This functionality allows users to:

* Find Relevant Information: Retrieve relevant data even without exact keyword matches.
* Enhance Large Language Models (LLMs): Employ semantic search to provide context for LLMs (Retrieval-Augmented Generation).
* Unleash Multimodal AI Applications: Combine structured and unstructured data with generative AI.

#### What this Block Enables

Our Looker Block unlocks the power of semantic search within your Looker environment. Key benefits include:

* Intuitive Search Interface: Eliminate the need to write SQL queries for semantic searches.
* Data Exploration: Uncover new insights within your data through semantically related searches.
* Streamlined Analysis: Reduce the time from query to insight, accelerating data utilization.

#### Example Use Case: eCommerce Product Discovery

Imagine using semantic search on an eCommerce dataset. Users can input natural language searches like "casual summer dresses" or "vintage electronics" and receive highly relevant product recommendations immediately. This enables:

* Custom Segment Refinement: Fine-tune and uncover new product segments based on natural language descriptions.
* Real-time Trend Adaptation: Discover and align product offerings with current trends.
* Audience Targeting: Identify potential customers based on shared interests and purchasing patterns.


## Getting Started

### Prerequisites

In Cloud Shell or a command line environment authenticated to `gcloud` run the following commands:

1. BigQuery project with required permissions (*BigQuery, BigQuery Connection, Vertex AI*) and APIs enabled.

    ```bash
    gcloud services enable bigquery.googleapis.com bigqueryconnection.googleapis.com aiplatform.googleapis.com
    ```
2. Remote connection in BigQuery with the service account provisioned with the Vertex AI User role.

    Export the following environment variables (filling them in for your specification:
    ```bash
    export REGION= &&
    export PROJECT_ID= &&
    export CONNECTION_ID= &&
    export PROJECT_NUMBER=
    ```
   Run this to provision the BigQuery Remote Connection:
   ```bash
   bq mk --connection --location=$REGION --project_id=$PROJECT_ID \
       --connection_type=CLOUD_RESOURCE $CONNECTION_ID
   ```

   Run this to return the Remote Connection Service Account:
   ```bash
   bq show --connection $PROJECT_ID.$REGION.$CONNECTION_ID
   ```

   Grab the Service Account ID from the above step & and grant it the Vertex AI User Role, replacing      `MEMBER` with that Service Account ID:
   ```bash
   gcloud projects add-iam-policy-binding '$PROJECT_NUMBER' --member='serviceAccount:MEMBER' --       role='roles/aiplatform.user' --condition=None
   ```

3. Looker instance with a BigQuery connection and the service account provisioned with the BigQuery Connection User role.

   Grab the Service Account ID used in your Looker instance's connection to BigQuery and replace  `MEMBER`   with it:
   ```bash
   gcloud projects add-iam-policy-binding '$PROJECT_NUMBER' --member='serviceAccount:MEMBER' --          role='roles/bigquery.connectionUser' --condition=None
   ```
4. Developer access to a Looker instance.

### Installation

1. Clone this GitHub repository: [GitHub Repo Link]
2. Create a LookML project within your Looker instance.
3. Connect the LookML project to your cloned repository.

## Tutorial

A comprehensive tutorial can be found in the repository ([link to tutorial]). It covers:

Configuring the block.
Understanding the semantic search views.
Creating and using the product embeddings model.
Generating product embeddings.
Indexing embeddings for efficient search.
Creating visualizations based on search results.
Next Steps & Enhancements

Parameter Optimization: Explore strategies for fine-tuning semantic search parameters for specific datasets.
Result Visualization: Experiment with ways to effectively visualize semantic search results within Looker dashboards.
Embedding Refinement: Investigate how to improve the quality and relevance of data embeddings.
---

#### Want to contribute?
We welcome contributions and feedback!  Please open issues and pull requests to help develop this block further.

Let us know what you build!
We're always excited to hear about new and innovative applications of semantic search within BigQuery.
