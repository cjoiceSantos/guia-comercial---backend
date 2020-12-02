const express = require('express');
const router = express.Router();
const multer = require('multer');
const AuthMidlleware = require('./middlewares/auth');

const multerConfig = require('./config/multer');
const UserController = require('./controllers/UserController');
const CompanyController = require('./controllers/CompanyController');
const CompanyProfileController = require('./controllers/CompanyProfileController');
const PromotionController = require('./controllers/PromotionController');
const CategoryController = require('./controllers/CategoryController');
const CommentsController = require('./controllers/CommentsController');
const SessionController = require('./controllers/SessionController');
const AuthController = require('./controllers/AuthController');

router.post('/auth/login', AuthController.login);
router.get('/auth/me', AuthMidlleware, AuthController.me);

router.post('/user', multer(multerConfig).single('file') ,UserController.insert);
router.delete('/user', UserController.delete);
router.put('/user', UserController.update);
router.put('/user/haveCompany', UserController.updateHave_Company);
router.get('/user', UserController.index);

router.post('/category', multer(multerConfig).single('file'), CategoryController.insert);
router.get('/category', CategoryController.index);
router.delete('/category/:id', CategoryController.delete);


router.post('/company',  multer(multerConfig).single('file'), CompanyController.insert);

router.get('/company', CompanyController.index);
router.delete('/company/:id', CompanyController.delete);
router.put('/company/:id', CompanyController.update);

router.get('/company/category/:id', CompanyProfileController.listForCategory);
router.get('/company/evaluations', CompanyProfileController.listForEvaluation);
router.get('/company/search/:term', CompanyProfileController.listBySearchTerm);
router.put('/company/evaluate/:id', CompanyProfileController.evaluateCompany);

router.post('/promotions/:company_id', PromotionController.insert);
router.get('/promotions/:company_id', PromotionController.listForCompany);
router.get('/promotions', PromotionController.index);
router.delete('/promotions/:company_id/:id', PromotionController.delete);
router.put('/promotions/:company_id/:id', PromotionController.update);

router.post('/comments/:company_id', CommentsController.insert);
router.get('/comments/:company_id', CommentsController.index);
router.delete('/comments/:company_id/:id', CommentsController.delete);

router.post('/session', SessionController.create);

module.exports = router;

