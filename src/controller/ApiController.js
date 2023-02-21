/**
 * @swagger
 * /items:
 *   get:
 *     description: Get all items available
 *     responses:
 *       200:
 *         description: Returns a mysterious string.
 */

import prisma from "../../prisma/prisma.js";

const ApiController = {
    getItems: async (req, res) => {
        const items = await prisma.item.findMany()
        res.json({
            data: items
        })
    },

    addItems: async(req, res) => {
        let body = req.body
        if (Object.keys(body).length == 0) {
            res
                .status(400)
                .json({
                    status: 'error',
                    message: 'There are no items to be added'
                })
            return
        } 
        
        let history = await prisma.history.create({
            data: {}
        })

        for (let item of body) {
            let id = item.id, amount = item.amount
            if (amount > 0){
                await prisma.itemAmount.create({
                    data: {
                        historyId: history.id,
                        itemId: id,
                        amount: amount
                    }
                })
            }
        }

        res
            .status(201)
            .json({
                status: 'success',
                message: 'Items added'
            })
    },

    getHistories: async (req, res) => {
        let groupedHistories = await prisma.history.groupBy({
            by: ['id', 'createdAt'],
            orderBy: {
                createdAt: 'desc'
            }
        })

        let countHistories = await prisma.itemAmount.groupBy({
            by: ['historyId'],
            _count: {
                historyId: true
            }
        })

        let histories = countHistories.map(count => {
            for (let group of groupedHistories) {
                if (group.id === count.historyId){
                    return {
                        ...group,
                        history_count: count._count.historyId
                    }
                } 
            }
        })

        histories.map(history => {
            history.history_id = history.id;
            history.created_at = history.createdAt; 
            delete history.createdAt
            delete history.id
        })
        
        res
            .status(200)
            .json({
                data: histories
            })
    },

    getHistoryDetails: async (req, res) => {
        let histories = await prisma.itemAmount.findMany({
            // include: {
            //     histories: true,
            //     items: true
            // },
            select: {
                historyId: true,
                amount: true,
                items: {
                    select: {
                        name: true
                    }
                }
            }
        })

        histories.map(history => {
            history.history_id = history.historyId
            history.name = history.items.name
            delete history.historyId
            delete history.items
        })

        res.json({
            data: histories
        })
    }
}

export default ApiController