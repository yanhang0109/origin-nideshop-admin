CREATE TABLE `nideshop_group_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品ID',
  `begin_time` int(11) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(11) DEFAULT NULL COMMENT '结束时间',
  `effect_time` int(11) DEFAULT NULL COMMENT '成团有效时间',
  `success_num` int(11) DEFAULT NULL COMMENT '成团人数',
  `limit_num` int(11) DEFAULT NULL COMMENT '限购数量',
  `group_price` decimal(12,2) DEFAULT NULL COMMENT '团购价',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(1发布 -1未发布 2已结束 3已失效)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='团购商品表';

CREATE TABLE `nideshop_group_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单ID',
  `group_id` bigint(20) DEFAULT NULL COMMENT '团单ID',
  `group_goods_id` bigint(20) DEFAULT NULL COMMENT '团购商品ID',
  `pay_time` int(11) DEFAULT NULL COMMENT '支付时间',
  `item_status` tinyint(4) DEFAULT NULL COMMENT '状态(1拼团中 -1待拼团 2拼团成功 3拼团失败)',
  `buyer_id` bigint(20) DEFAULT NULL COMMENT '购买人',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='团购明细表';

CREATE TABLE `nideshop_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_goods_id` bigint(20) DEFAULT NULL COMMENT '团购商品ID',
  `start_time` int(11) DEFAULT NULL COMMENT '发起拼团时间',
  `finish_time` int(11) DEFAULT NULL COMMENT '拼团结束时间',
  `hav_num` int(11) DEFAULT NULL COMMENT '已购人数',
  `success_num` int(11) DEFAULT NULL COMMENT '成团人数',
  `limit_num` int(11) DEFAULT NULL COMMENT '限购数量',
  `group_price` decimal(12,2) DEFAULT NULL COMMENT '团购价',
  `group_status` tinyint(4) DEFAULT NULL COMMENT '状态(1活动中 -1未开始 2已成功 3已失败 4已失效)',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '第一个购买人',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='团单表';

ALTER TABLE nideshop_goods ADD is_group tinyint(1), ADD original_price decimal(12,2);