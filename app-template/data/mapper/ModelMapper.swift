//
//  TaskMapper.swift
//  ios-swift-start
//
//  Created by alopezh on 22/09/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

protocol ModelMapper {
	associatedtype DataModel
	associatedtype DomainModel

	static func transform(_ dataModel: DataModel) -> DomainModel
	static func transform(_ domainModel: DomainModel) -> DataModel
	static func listTransformModel(_ dataModelList: [DataModel]) -> [DomainModel]
	static func listTransformModel(_ domainModelList: [DomainModel]) -> [DataModel]
}

extension ModelMapper {
	static func listTransformModel(_ dataModelList: [DataModel]) -> [DomainModel] {
		return dataModelList.compactMap(self.transform(_:))
	}

	static func listTransformModel(_ domainModelList: [DomainModel]) -> [DataModel] {
		return domainModelList.compactMap(self.transform(_:))
	}
}
