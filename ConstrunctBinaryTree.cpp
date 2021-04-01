#include <exception>
#include <cstdio>
#pragma once

struct BinaryTreeNode 
{
    int                    m_nValue; 
    BinaryTreeNode*        m_pLeft;  
    BinaryTreeNode*        m_pRight; 
};

BinaryTreeNode* CreateBinaryTreeNode(int value)
{
    BinaryTreeNode* pNode = new BinaryTreeNode();
    pNode->m_nValue = value;
    pNode->m_pLeft = nullptr;
    pNode->m_pRight = nullptr;
    
    return pNode;
}

void ConnectTreeNodes(BinaryTreeNode* pParent, BinaryTreeNode* pLeft, BinaryTreeNode* pRight)
{
    if(pParent != nullptr)
        {
            pParent->m_pLeft = pLeft;
            pParent->m_pRight = pRight;
        }
}

void PrintTreeNode(const BinaryTreeNode* pNode)
{
    if(pNode != nullptr)
        {
            printf("value of this node is: %d\n", pNode->m_nValue);
            
            if(pNode->m_pLeft != nullptr)
                printf("value of its left child is: %d.\n", pNode->m_pLeft->m_nValue);
            else
                printf("left child is nullptr.\n");
            
            if(pNode->m_pRight != nullptr)
                printf("value of its right child is: %d.\n", pNode->m_pRight->m_nValue);
            else
                printf("right child is nullptr.\n");
        }
    else
        {
            printf("this node is nullptr.\n");
        }
    
    printf("\n");
}

void PrintTree(const BinaryTreeNode* pRoot)
{
    PrintTreeNode(pRoot);
    
    if(pRoot != nullptr)
        {
            if(pRoot->m_pLeft != nullptr)
                PrintTree(pRoot->m_pLeft);
            
            if(pRoot->m_pRight != nullptr)
                PrintTree(pRoot->m_pRight);
        }
}

void DestroyTree(BinaryTreeNode* pRoot)
{
    if(pRoot != nullptr)
        {
            BinaryTreeNode* pLeft = pRoot->m_pLeft;
            BinaryTreeNode* pRight = pRoot->m_pRight;
            
            delete pRoot;
            pRoot = nullptr;
            
            DestroyTree(pLeft);
            DestroyTree(pRight);
        }
}


BinaryTreeNode* ConstructCore(int* startPreorder, int* endPreorder, int* startInorder, int* endInorder);

BinaryTreeNode* Construct(int* preorder, int* inorder, int length)
{
    if(preorder == nullptr || inorder == nullptr || length <= 0)
        return nullptr;

    return ConstructCore(preorder, preorder + length - 1,
        inorder, inorder + length - 1);
}

BinaryTreeNode* ConstructCore
(
    int* startPreorder, int* endPreorder, 
    int* startInorder, int* endInorder
)
{
    // 前序遍历序列的第一个数字是根结点的值
    int rootValue = startPreorder[0];
    BinaryTreeNode* root = new BinaryTreeNode();
    root->m_nValue = rootValue;
    root->m_pLeft = root->m_pRight = nullptr;

    if(startPreorder == endPreorder)
    {
        if(startInorder == endInorder && *startPreorder == *startInorder)
            return root;
//        else
//            throw std::exception("Invalid input.");
    }

    // 在中序遍历中找到根结点的值
    int* rootInorder = startInorder;
    while(rootInorder <= endInorder && *rootInorder != rootValue)
        ++ rootInorder;

//    if(rootInorder == endInorder && *rootInorder != rootValue)
//        throw std::exception("Invalid input.");

    int leftLength = rootInorder - startInorder;
    int* leftPreorderEnd = startPreorder + leftLength;
    if(leftLength > 0)
    {
        // 构建左子树
        root->m_pLeft = ConstructCore(startPreorder + 1, leftPreorderEnd, 
            startInorder, rootInorder - 1);
    }
    if(leftLength < endPreorder - startPreorder)
    {
        // 构建右子树
        root->m_pRight = ConstructCore(leftPreorderEnd + 1, endPreorder,
            rootInorder + 1, endInorder);
    }

    return root;
}