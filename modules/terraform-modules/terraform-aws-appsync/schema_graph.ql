input CreateMetadataInput {
	dataset_id: String!
	dataset_name: String!
	dataset_description: String!
	dataset_size: Float!
	created_date: String!
	user_id: String
	created_by: String!
	requested_by: String
	approved_by: String
	modified_date: String
	ingressed_date: String!
	site_name: String!
	project_name: String!
	project_id: String
	region: String
	org_name: String!
	org_id: String
	data_maturity: String!
	data_classification: String!
	bucket_details: String
	data_files_count: Int!
	files_list: AWSJSON!
	data_modality: [String]
}

input DeleteMetadataInput {
	dataset_id: String!
}

type Metadata {
	dataset_id: String
	dataset_name: String
	dataset_description: String
	dataset_size: Float
	created_date: String
	user_id: String
	created_by: String
	requested_by: String
	approved_by: String
	modified_date: String
	ingressed_date: String
	site_name: String
	project_name: String
	project_id: String
	region: String
	org_name: String
	org_id: String
	data_maturity: String
	data_classification: String
	bucket_details: String
	data_files_count: Int
	files_list: AWSJSON
	data_modality: [String]
}

type MetadataCollection {
	items: [Metadata]
	nextToken: String
	scannedCount: Int
}

input TableBooleanFilterInput {
	ne: Boolean
	eq: Boolean
}

input TableFloatFilterInput {
	ne: Float
	eq: Float
	le: Float
	lt: Float
	ge: Float
	gt: Float
	contains: Float
	notContains: Float
	between: [Float]
}

input TableIDFilterInput {
	ne: ID
	eq: ID
	le: ID
	lt: ID
	ge: ID
	gt: ID
	contains: ID
	notContains: ID
	between: [ID]
	beginsWith: ID
}

input TableIntFilterInput {
	ne: Int
	eq: Int
	le: Int
	lt: Int
	ge: Int
	gt: Int
	contains: Int
	notContains: Int
	between: [Int]
}

input TableIntSearchFilterInput {
	ne: Int
	eq: [Int]
	le: Int
	lt: Int
	ge: Int
	gt: Int
	contains: Int
	notContains: Int
	between: [Int]
	operation: String
	order: Int
}

input TableMetadataFilterInput {
	dataset_id: TableStringFilterInput
	dataset_name: TableStringFilterInput
	dataset_description: TableStringFilterInput
	dataset_size: TableFloatFilterInput
	created_date: TableStringFilterInput
	user_id: TableStringFilterInput
	created_by: TableStringFilterInput
	requested_by: TableStringFilterInput
	approved_by: TableStringFilterInput
	modified_date: TableStringFilterInput
	ingressed_date: TableStringFilterInput
	site_name: TableStringFilterInput
	project_name: TableStringFilterInput
	project_id: TableStringFilterInput
	region: TableStringFilterInput
	org_name: TableStringFilterInput
	org_id: TableStringFilterInput
	data_maturity: TableStringFilterInput
	data_classification: TableStringFilterInput
	data_files_count: TableIntFilterInput
	and: [TableMetadataFilterInput]
	or: [TableMetadataFilterInput]
	not: TableMetadataFilterInput
}

input TableMetadataSearchInput {
	dataset_id: TableStringSearchInput
	dataset_name: TableStringSearchInput
	dataset_description: TableStringSearchInput
	dataset_size: TableIntSearchFilterInput
	created_date: TableStringSearchInput
	user_id: TableStringSearchInput
	created_by: TableStringSearchInput
	requested_by: TableStringSearchInput
	approved_by: TableStringSearchInput
	modified_date: TableStringSearchInput
	ingressed_date: TableStringSearchInput
	site_name: TableStringSearchInput
	project_name: TableStringSearchInput
	project_id: TableStringSearchInput
	region: TableStringSearchInput
	org_name: TableStringSearchInput
	org_id: TableStringSearchInput
	data_maturity: TableStringSearchInput
	data_classification: TableStringSearchInput
	data_modality: TableStringListFilterInput
	data_files_count: TableIntSearchFilterInput
}

input TableStringFilterInput {
	ne: String
	eq: String
	le: String
	lt: String
	ge: String
	gt: String
	contains: String
	notContains: String
	between: [String]
}

input TableStringListFilterInput {
	ne: [String]
	eq: [String]
	le: [String]
	lt: [String]
	ge: [String]
	gt: [String]
	contains: String
	notContains: String
	between: [String]
}

input TableStringSearchInput {
	ne: String
	eq: [String]
	le: String
	lt: String
	ge: String
	gt: String
	contains: String
	notContains: String
	between: [String]
	beginsWith: String
	operation: String
	order: Int
}

input UpdateMetadataInput {
	dataset_id: String!
	dataset_name: String
	dataset_description: String
	dataset_size: Float
	created_date: String
	user_id: String
	created_by: String
	requested_by: String
	approved_by: String
	modified_date: String
	ingressed_date: String
	site_name: String
	project_name: String
	project_id: String
	region: String
	org_name: String
	org_id: String
	data_maturity: String
	data_classification: String
	bucket_details: String
	data_files_count: Int
	files_list: AWSJSON
	data_modality: [String]
}

type Mutation {
	createMetadata(input: CreateMetadataInput!): Metadata
	updateMetadata(input: UpdateMetadataInput!): Metadata
	deleteMetadata(input: DeleteMetadataInput!): Metadata
}

type Query {
	queryMetadataByDatasetId(dataset_id: String!, limit: Int): MetadataCollection
	queryMetadataByProjectId(project_id: String!, limit: Int, nextToken: String): MetadataCollection
	listMetadata(filter: TableMetadataFilterInput, limit: Int, nextToken: String): MetadataCollection
	searchMetadata(
		filter: TableMetadataSearchInput,
		filterOperation: String,
		limit: Int,
		nextToken: String
	): MetadataCollection
	searchMetadataByProjectkey(
    		filter: TableMetadataSearchInput,
    		filterOperation: String,
    		limit: Int,
    		nextToken: String
    	): MetadataCollection
}

type Subscription {
	onCreateMetadata(
		dataset_id: String,
		dataset_name: String,
		dataset_description: String,
		dataset_size: Float,
		created_date: String
	): Metadata
		@aws_subscribe(mutations: ["createMetadata"])
	onUpdateMetadata(
		dataset_id: String,
		dataset_name: String,
		dataset_description: String,
		dataset_size: Float,
		created_date: String
	): Metadata
		@aws_subscribe(mutations: ["updateMetadata"])
	onDeleteMetadata(
		dataset_id: String,
		dataset_name: String,
		dataset_description: String,
		dataset_size: Float,
		created_date: String
	): Metadata
		@aws_subscribe(mutations: ["deleteMetadata"])
}
